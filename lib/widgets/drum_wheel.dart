import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrumWheel extends StatelessWidget {
  final FixedExtentScrollController controller;
  final double itemExtent;
  final int itemCount;
  final int selectedIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedBackground;
  final Widget Function(int index, bool isSelected) itemBuilder;
  final ValueChanged<int> onSelectedItemChanged;

  const DrumWheel({
    required this.controller,
    required this.itemExtent,
    required this.itemCount,
    required this.selectedIndex,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedBackground,
    required this.itemBuilder,
    required this.onSelectedItemChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = List.generate(itemCount, (index) {
      final isSelected = index == selectedIndex;
      return Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 120),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? selectedColor : unselectedColor,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: itemBuilder(index, isSelected),
          ),
        ),
      );
    });

    return CupertinoPicker(
      scrollController: controller,
      itemExtent: itemExtent,
      diameterRatio: 1.45,
      squeeze: 1.12,
      useMagnifier: true,
      magnification: 1.08,
      onSelectedItemChanged: onSelectedItemChanged,
      backgroundColor: Colors.transparent,
      selectionOverlay: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selectedBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selectedColor.withValues(alpha: 0.45),
            width: 1.1,
          ),
        ),
      ),
      children: items,
    );
  }
}
