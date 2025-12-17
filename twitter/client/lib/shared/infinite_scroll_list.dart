import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

/// A reusable infinite scroll list widget for paginated entity queries.
///
/// This widget manages scroll state, page loading, and pagination logic
/// for any entity query that supports reverse pagination.
class InfiniteScrollListView<Q extends EntityQuery> extends StatefulWidget {
  const InfiniteScrollListView({
    super.key,
    required this.entityId,
    required this.createQuery,
    required this.listSelector,
    required this.itemBuilder,
    this.pageSize = 10,
    this.emptyWidget,
    this.loadingWidget,
    this.errorWidget,
  });

  /// The entity ID to query.
  final String entityId;

  /// Factory function to create a query with pagination parameters.
  final Q Function(String endBefore, int pageSize) createQuery;

  /// Function which selects the list view in the query.
  final ListSelector<Q> listSelector;

  /// Builder for rendering items from the loaded page. Query [Q] is available via context of this builder function.
  final Widget Function(BuildContext context, int pageIndex) itemBuilder;

  /// Number of items per page.
  final int pageSize;

  /// Widget to show when a page is empty.
  final Widget? emptyWidget;

  /// Widget to show while a page is loading.
  final Widget? loadingWidget;

  /// Widget to show when a page failed to load.
  final Widget? errorWidget;

  @override
  State<InfiniteScrollListView<Q>> createState() =>
      _InfiniteScrollListViewState<Q>();
}

class _InfiniteScrollListViewState<Q extends EntityQuery>
    extends State<InfiniteScrollListView<Q>> {
  @override
  void initState() {
    super.initState();
    // Load first page
    _pages.add(widget.createQuery('', widget.pageSize));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _pages.length,
      itemBuilder: (context, pageIndex) {
        final query = _pages[pageIndex];
        final isNotLastItem = pageIndex != _pages.length - 1;

        return context.entityQuery(
          entityId: widget.entityId,
          query: query,
          loading: _PageLoadingWidget(
            wasLoadedBefore: isNotLastItem,
            loadingWidget: widget.loadingWidget,
          ),
          error:
              widget.errorWidget ??
              const Center(child: Text('Error loading page')),
          child: _PageLoadedWidget(
            pageIndex: pageIndex,
            onPageLoaded: _onPageLoaded,
            syncCursor: _syncCursor,
            itemBuilder: widget.itemBuilder,
            listSelector: widget.listSelector,
            emptyWidget: widget.emptyWidget,
          ),
        );
      },
    );
  }

  void _onScroll() {
    if (_isLoadingNextPage) return;

    // Check if near bottom (200px from bottom)
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll < 200) {
      _loadNextPage();
    }
  }

  void _loadNextPage() {
    if (!mounted) return;

    // Don't load more if last page wasn't full
    if (_lastPageItemCount < widget.pageSize) return;

    setState(() {
      _isLoadingNextPage = true;
      _pages.add(widget.createQuery(_nextEndBefore, widget.pageSize));
    });
  }

  // A callback which let's the child page signal to it's parent that it has finished loading.
  void _onPageLoaded(int pageIndex, int itemCount, String? cursor) {
    if (!mounted) return;

    // Update the cursor for the next page
    if (pageIndex == _pages.length - 1) {
      if (cursor != null) {
        _nextEndBefore = cursor;
      }
      _isLoadingNextPage = false;
    }
    _lastPageItemCount = itemCount;
  }

  /// A callback which allows the child page sync the pagination cursor data - [_lastPageItemCount] and [_nextEndBefore].
  /// Must not perfrom [setState] or trigger parent rebuilds in any other way, because this callback is executed in child page's build method.
  void _syncCursor(int pageIndex, int itemCount, String? firstItemKey) {
    // Only update for the last page
    if (pageIndex == _pages.length - 1) {
      _lastPageItemCount = itemCount;
      if (firstItemKey != null) {
        _nextEndBefore = firstItemKey;
      }
    }
  }

  /// This infinite list is essentially a list of pages. Each page contains [InfiniteScrollListView.pageSize] elements.
  /// Pages are actually [EntityQuery]s of type [Q]. Each page simply runs it's query and calls [InfiniteScrollListView.itemBuilder] to render items.
  final List<Q> _pages = [];

  final ScrollController _scrollController = ScrollController();

  /// The pagination cursor. Used as the "endBefore" pagination parameter in the query for the next page.
  String _nextEndBefore = '';

  /// Let's us avoid loading any more pages while there is a page in the loading state.
  bool _isLoadingNextPage = false;

  /// Let's us start loading the next page only if the last page is or has become full.
  int _lastPageItemCount = 0;
}

class _PageLoadingWidget extends StatelessWidget {
  const _PageLoadingWidget({
    this.wasLoadedBefore = false,
    this.loadingWidget,
  });

  final bool wasLoadedBefore;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    // Use larger height for previously loaded pages to maintain scroll position
    final double height = wasLoadedBefore ? 1000 : 100;
    return SizedBox(
      height: height,
      child: loadingWidget ?? const Center(child: CircularProgressIndicator()),
    );
  }
}

class _PageLoadedWidget<Q extends EntityQuery> extends StatefulWidget {
  const _PageLoadedWidget({
    required this.pageIndex,
    required this.onPageLoaded,
    required this.syncCursor,
    required this.itemBuilder,
    required this.listSelector,
    this.emptyWidget,
  });

  final int pageIndex;
  final void Function(int pageIndex, int itemCount, String? cursor)
  onPageLoaded;
  final void Function(int pageIndex, int itemCount, String? cursor) syncCursor;
  final Widget Function(BuildContext context, int pageIndex) itemBuilder;
  final ListSelector<Q> listSelector;
  final Widget? emptyWidget;

  @override
  State<_PageLoadedWidget<Q>> createState() => _PageLoadedWidgetState<Q>();
}

class _PageLoadedWidgetState<Q extends EntityQuery>
    extends State<_PageLoadedWidget<Q>> {
  @override
  void initState() {
    super.initState();

    final itemCount = context.lookup<Q>().listLength(widget.listSelector);
    final firstItemKey = context
        .lookup<Q>()
        .listItems(widget.listSelector)
        .firstOrNull
        ?.key;

    widget.onPageLoaded(widget.pageIndex, itemCount, firstItemKey);
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = context.query<Q>().listLength(widget.listSelector);
    final firstItemKey = context
        .query<Q>()
        .listItems(widget.listSelector)
        .firstOrNull
        ?.key;

    // Sync item count with parent during build. This function does not trigger rebuilds, simply mutates state.
    widget.syncCursor(widget.pageIndex, itemCount, firstItemKey);

    if (itemCount == 0) {
      // Empty page - might be the first page with no items
      if (widget.pageIndex == 0) {
        return widget.emptyWidget ??
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No items yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
      }

      return const SizedBox.shrink();
    }

    return widget.itemBuilder(context, widget.pageIndex);
  }
}
