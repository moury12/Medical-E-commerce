import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      this.child,
      this.height,
      this.width,
      this.padding,
      this.borderRadius,
      this.backgroundColor,
      this.gradient,
      this.boxShadow,
      this.borderWidth,
      this.borderColor});
  final Widget? child;
  final double? height, width, borderWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor, borderColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: const Offset(5, 0))
            ],
        gradient: gradient,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
      ),
      child: child,
    );
  }
}
