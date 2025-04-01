import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeoContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isPressed;

  const NeoContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.isPressed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(20),
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
            offset: Offset(8, 8),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-8, -8),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}