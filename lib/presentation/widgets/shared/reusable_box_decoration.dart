import 'package:flutter/material.dart';

class ReusableBoxDecoration extends StatelessWidget {
  
  final Widget child;
  final Color color;
  final Color shadowColor;
  
  const ReusableBoxDecoration({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.shadowColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 3.5, color: color),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(7.5, 7.5),
            )
          ]
      ),
      child: child,
    );
  }
}