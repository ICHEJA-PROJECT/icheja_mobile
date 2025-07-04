import 'package:flutter/material.dart';

class GridContainer<T> extends StatelessWidget {
  final int gridColumns;
  final double gridVerticalPadding;
  final double gridHorizontalPadding;
  final double aspectRatioItem;
  final List<T> items;
  final Widget Function(T item, int index, Map<String, dynamic>? extraData)
      itemContent;
  final Map<String, dynamic>? extraData;

  const GridContainer({
    super.key,
    this.gridColumns = 2,
    this.gridVerticalPadding = 13,
    this.gridHorizontalPadding = 10,
    this.aspectRatioItem = 1.0,
    required this.items,
    required this.itemContent,
    this.extraData,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridColumns,
        mainAxisSpacing: gridVerticalPadding,
        crossAxisSpacing: gridHorizontalPadding,
        childAspectRatio: aspectRatioItem,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return itemContent(item, index, extraData);
      },
    );
  }
}
