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

  /// The entity ID to query
  final String entityId;

  /// Factory function to create a query with pagination parameters
  final Q Function(String endBefore, int pageSize) createQuery;

  /// Function which selects the list view in the query.
  final ListSelector<Q> listSelector;

  /// Builder for rendering items from the loaded page
  final Widget Function(BuildContext context, int pageIndex) itemBuilder;

  /// Number of items per page
  final int pageSize;

  /// Widget to show when the list is empty
  final Widget? emptyWidget;

  /// Widget to show while loading
  final Widget? loadingWidget;

  /// Widget to show on error
  final Widget? errorWidget;

  @override
  State<InfiniteScrollListView<Q>> createState() =>
      _InfiniteScrollListViewState<Q>();
}

class _InfiniteScrollListViewState<Q extends EntityQuery>
    extends State<InfiniteScrollListView<Q>> {
  final List<Q> _pages = [];
  final ScrollController _scrollController = ScrollController();
  String _nextEndBefore = '';
  bool _isLoadingNextPage = false;
  int _lastPageItemCount = 0;

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

  /// Sync cursor during build without triggering setState.
  void _syncCursor(int pageIndex, int itemCount, String? cursor) {
    // Only update for the last page
    if (pageIndex == _pages.length - 1) {
      _lastPageItemCount = itemCount;
      if (cursor != null) {
        _nextEndBefore = cursor;
      }
    }
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
            onEmpty: widget.emptyWidget,
          ),
        );
      },
    );
  }
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
    this.onEmpty,
  });

  final int pageIndex;
  final void Function(int pageIndex, int itemCount, String? cursor)
  onPageLoaded;
  final void Function(int pageIndex, int itemCount, String? cursor) syncCursor;
  final Widget Function(BuildContext context, int pageIndex) itemBuilder;
  final ListSelector<Q> listSelector;
  final Widget? onEmpty;

  @override
  State<_PageLoadedWidget> createState() => _PageLoadedWidgetState<Q>();
}

class _PageLoadedWidgetState<Q extends EntityQuery>
    extends State<_PageLoadedWidget> {
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
        return widget.onEmpty ??
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
