import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum PlaceholderType {
  card,
  list,
  profile,
  text,
  custom,
}

class LoadingPlaceholder extends StatelessWidget {
  final PlaceholderType type;
  final double height;
  final double width;
  final BorderRadius? borderRadius;
  final int itemCount;
  final double itemSpacing;
  final EdgeInsetsGeometry? padding;
  final Color baseColor;
  final Color highlightColor;
  final Widget? customChild;

  const LoadingPlaceholder({
    super.key,
    this.type = PlaceholderType.card,
    this.height = 200,
    this.width = double.infinity,
    this.borderRadius,
    this.itemCount = 1,
    this.itemSpacing = 16,
    this.padding,
    this.baseColor = const Color(0xFFEEEEEE),
    this.highlightColor = const Color(0xFFFAFAFA),
    this.customChild,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 1500),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: _buildByType(),
      ),
    );
  }

  Widget _buildByType() {
    switch (type) {
      case PlaceholderType.card:
        return _buildCardPlaceholder();
      case PlaceholderType.list:
        return _buildListPlaceholder();
      case PlaceholderType.profile:
        return _buildProfilePlaceholder();
      case PlaceholderType.text:
        return _buildTextPlaceholder();
      case PlaceholderType.custom:
        return customChild ?? Container();
    }
  }

  Widget _buildCardPlaceholder() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildListPlaceholder() {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Column(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius ?? BorderRadius.circular(8),
              ),
            ),
            if (index < itemCount - 1) SizedBox(height: itemSpacing),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePlaceholder() {
    return Row(
      children: [
        Container(
          height: height,
          width: height, // Make it square for profile pic
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 12,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        itemCount,
        (index) => Column(
          children: [
            Container(
              height: height,
              width: index % 2 == 0 ? width : width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            if (index < itemCount - 1) SizedBox(height: itemSpacing / 2),
          ],
        ),
      ),
    );
  }
} 