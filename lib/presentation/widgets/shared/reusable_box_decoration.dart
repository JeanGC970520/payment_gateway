import 'package:flutter/material.dart';

class ReusableBoxDecoration extends StatelessWidget {
  
  final Widget child;
  final Color color;
  final Color shadowColor;
  final double horizontalPadding;
  
  const ReusableBoxDecoration({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.shadowColor = Colors.black87,
    this.horizontalPadding = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 3.5, color: shadowColor),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(7.5, 7.5),
            )
          ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding,),
        child: child,
      ),
    );
  }
}