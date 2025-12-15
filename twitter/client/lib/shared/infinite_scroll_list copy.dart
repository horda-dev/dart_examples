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
    required this.itemBuilder,
    required this.getItemCount,
    required this.getLastItemKey,
    this.pageSize = 10,
    this.emptyWidget,
    this.loadingWidget,
    this.errorWidget,
  });

  /// The entity ID to query
  final String entityId;

  /// Factory function to create a query with pagination parameters
  final Q Function(String endBefore, int pageSize) createQuery;

  /// Builder for rendering items from the loaded page
  final Widget Function(BuildContext context, int pageIndex) itemBuilder;

  /// Function to get the number of items in a page
  final int Function(BuildContext context) getItemCount;

  /// Function to get the last item key from a page (for pagination cursor)
  final String? Function(BuildContext context, int itemCount) getLastItemKey;

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

  void _onPageLoaded(int pageIndex, int itemCount, String? lastItemKey) {
    if (!mounted) return;

    // Update the cursor for the next page
    if (pageIndex == _pages.length - 1) {
      if (lastItemKey != null) {
        _nextEndBefore = lastItemKey;
      }
      _isLoadingNextPage = false;
    }
    _lastPageItemCount = itemCount;
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
            itemBuilder: widget.itemBuilder,
            getItemCount: widget.getItemCount,
            getLastItemKey: widget.getLastItemKey,
            emptyWidget: widget.emptyWidget,
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

class _PageLoadedWidget extends StatefulWidget {
  const _PageLoadedWidget({
    required this.pageIndex,
    required this.onPageLoaded,
    required this.itemBuilder,
    required this.getItemCount,
    required this.getLastItemKey,
    this.emptyWidget,
  });

  final int pageIndex;
  final void Function(int pageIndex, int itemCount, String? lastItemKey)
  onPageLoaded;
  final Widget Function(BuildContext context, int pageIndex) itemBuilder;
  final int Function(BuildContext context) getItemCount;
  final String? Function(BuildContext context, int itemCount) getLastItemKey;
  final Widget? emptyWidget;

  @override
  State<_PageLoadedWidget> createState() => _PageLoadedWidgetState();
}

class _PageLoadedWidgetState extends State<_PageLoadedWidget> {
  @override
  void initState() {
    super.initState();
    // Notify parent when this page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final itemCount = widget.getItemCount(context);
      final lastItemKey = widget.getLastItemKey(context, itemCount);

      widget.onPageLoaded(widget.pageIndex, itemCount, lastItemKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.getItemCount(context);

    // Sync item count with parent during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final currentCount = widget.getItemCount(context);
      final lastItemKey = widget.getLastItemKey(context, currentCount);
      widget.onPageLoaded(widget.pageIndex, currentCount, lastItemKey);
    });

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
