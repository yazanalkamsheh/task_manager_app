import 'package:flutter/material.dart';

import '../utils/base_pagination_bloc/pagination_state.dart';

class PaginatedListView<E> extends StatefulWidget {
  final Function(int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Function() onCallMoreData;
  final Function()? onRefresh;
  final EdgeInsetsDirectional? padding;
  final PaginationState<List<E>> state;

  const PaginatedListView({
    super.key,
    required this.itemBuilder,
    this.onRefresh,
    required this.onCallMoreData,
    this.separatorBuilder,
    this.padding,
    required this.state,
  });

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: widget.padding,
        controller: _scrollController,
        separatorBuilder:
        widget.separatorBuilder ?? (context, index) => const SizedBox(),
        itemCount: _calculateItemCount(),
        itemBuilder: (context, index) {
          if (index < widget.state.data!.length) {
            return widget.itemBuilder(index);
          } else {
            return _buildLoadingIndicator();
          }
        },
      ),
    );
  }

  int _calculateItemCount() {
    if (widget.state.hasReachMax) {
      return widget.state.data!.length;
    } else {
      // Add 1 to show loading indicator at the end
      return widget.state.data!.length + 1;
    }
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!widget.state.hasReachMax) widget.onCallMoreData.call();
    }
  }
}
