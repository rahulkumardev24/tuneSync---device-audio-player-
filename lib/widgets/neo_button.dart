import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeoButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final bool isPressed;
  final Color btnBackGroundColor ;

  const NeoButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding,
    this.isPressed = false,
    this.btnBackGroundColor = const Color(0xFFE0E5EC)
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: btnBackGroundColor,
          boxShadow: isPressed
              ? [
            const BoxShadow(
              color: Color(0xFFA3B1C6),
              offset: Offset(2, 2),
              blurRadius: 5,
              spreadRadius: 1,

            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 5,
              spreadRadius: 1,
            ),


          ]
              : [
            const BoxShadow(
              color: Color(0xFFA3B1C6),
              offset: Offset(6, 6),
              blurRadius: 8,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-6, -6),
              blurRadius: 8,
              spreadRadius: 1,
            ),


          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}