import 'package:flutter/material.dart';

class TabToggle extends StatelessWidget {
  const TabToggle({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.activeColor,
    required this.inActiveColor,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inActiveColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inActiveColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
