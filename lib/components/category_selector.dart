import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlantCategory {
  final String name;
  final IconData icon;
  final Color color;

  const PlantCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategorySelector extends StatefulWidget {
  final List<PlantCategory> categories;
  final Function(int) onCategorySelected;
  final int initialSelected;
  final double height;
  final double itemWidth;
  final double borderRadius;
  final double spacing;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;
  final Color selectedTextColor;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.initialSelected = 0,
    this.height = 50,
    this.itemWidth = 100,
    this.borderRadius = 25,
    this.spacing = 10,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.selectedColor = const Color(0xFF4CAF50),
    this.textColor = Colors.black54,
    this.selectedTextColor = Colors.white,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  late int _selectedIndex;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelected;
    
    // Scroll to the initially selected item after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final double itemExtent = widget.itemWidth + widget.spacing;
        final double offset = (_selectedIndex * itemExtent) - 
                              (_scrollController.position.viewportDimension / 2 - itemExtent / 2);
        
        if (offset > 0 && offset < _scrollController.position.maxScrollExtent) {
          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.spacing),
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) => SizedBox(width: widget.spacing),
        itemBuilder: (context, index) {
          final bool isSelected = index == _selectedIndex;
          final category = widget.categories[index];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onCategorySelected(index);
            },
            child: Container(
              width: widget.itemWidth,
              decoration: BoxDecoration(
                color: isSelected ? category.color : category.color.withAlpha(77),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: category.color.withAlpha(77),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ] : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    color: isSelected ? widget.selectedTextColor : category.color,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category.name,
                    style: TextStyle(
                      color: isSelected ? widget.selectedTextColor : widget.textColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
            .animate(target: isSelected ? 1 : 0)
            .elevation(
              begin: 0,
              end: 5,
              curve: Curves.easeOut,
              duration: 200.ms,
            )
            .scale(
              begin: const Offset(0.95, 0.95),
              end: const Offset(1, 1),
              curve: Curves.easeOut,
              duration: 200.ms,
            ),
          );
        },
      ),
    );
  }
} 