import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Widget? child;
  final TextStyle? style;
  final TextStyle? additionalStyle;
  final bool showStar;
  final TextAlign textAlign;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? lineHeight;

  const CustomText({
    super.key,
    this.text,
    this.child,
    this.style,
    this.additionalStyle,
    this.showStar = false,
    this.textAlign = TextAlign.left,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.lineHeight,
  }) : assert(text != null || child != null, 'Either text or child must be provided');

  @override
  Widget build(BuildContext context) {
    // If child is provided, return it directly (for custom components)
    if (child != null) {
      return child!;
    }

    // Build the base text style
    final baseStyle = TextStyle(
      fontSize: fontSize ?? 16.0, // TextSize.TEXT_MEDIUM equivalent
      color: textColor ?? Colors.black, // Colors.CARRIER_BLACK equivalent
      fontWeight: fontWeight ?? FontWeight.w500,
      letterSpacing: letterSpacing,
      height: lineHeight,
    );

    // Merge with additional styles
    final effectiveStyle = (style ?? baseStyle).merge(additionalStyle);

    // If showStar is true, use RichText to add red star
    if (showStar && text != null) {
      return RichText(
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.ellipsis,
        text: TextSpan(
          style: effectiveStyle,
          children: [
            TextSpan(text: text),
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }

    // Regular text without star
    return Text(
      text ?? '',
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}

// Convenience constructors for common use cases
class CustomLabel extends CustomText {
  const CustomLabel({
    super.key,
    required super.text,
    super.style,
    super.additionalStyle,
    super.showStar = false,
    super.textColor,
    super.fontSize,
    super.maxLines,
    super.overflow,
  }) : super(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w500,
        );
}

class CustomHeader extends CustomText {
  const CustomHeader({
    super.key,
    required super.text,
    super.style,
    super.additionalStyle,
    super.showStar = false,
    super.textColor,
    super.maxLines,
    super.overflow,
  }) : super(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        );
}

