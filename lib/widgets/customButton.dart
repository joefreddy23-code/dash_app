import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? text;
  final Widget? child;
  final bool disabled;
  final double opacity;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;

  const CustomButton({
    super.key,
    required this.onPress,
    this.text,
    this.child,
    this.disabled = false,
    this.opacity = 1.0,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOpacity = disabled ? 0.5 : opacity;
    final effectiveHeight = height ?? 45.0;
    final effectiveBorderRadius = borderRadius ?? 10.0;
    final effectiveBackgroundColor = backgroundColor ?? Colors.green;
    final effectiveTextColor = textColor ?? Colors.white;

    return Opacity(
      opacity: effectiveOpacity,
      child: GestureDetector(
        onTap: disabled ? null : onPress,
        child: Container(
          height: effectiveHeight,
          decoration: decoration ??
              BoxDecoration(
                color: effectiveBackgroundColor,
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              ),
          padding: padding,
          child: Center(
            child: child ??
                Text(
                  text ?? '',
                  style: textStyle ??
                      TextStyle(
                        color: effectiveTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}

