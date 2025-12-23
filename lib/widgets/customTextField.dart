import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final Widget? labelComponent;
  final Widget? inputComponent;
  final TextStyle? additionalLabelStyle;
  final TextStyle? inputStyle;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final VoidCallback? onPressRight;
  final VoidCallback? onPressLeft;
  final String? placeholder;
  final String? value;
  final ValueChanged<String>? onChangeText;
  final bool secureTextEntry;
  final bool disabled;
  final double opacity;
  final bool showStar;
  final String? error;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;
  final Color? errorBorderColor;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    this.label,
    this.labelComponent,
    this.inputComponent,
    this.additionalLabelStyle,
    this.inputStyle,
    this.rightIcon,
    this.leftIcon,
    this.onPressRight,
    this.onPressLeft,
    this.placeholder,
    this.value,
    this.onChangeText,
    this.secureTextEntry = false,
    this.disabled = false,
    this.opacity = 1.0,
    this.showStar = false,
    this.error,
    this.errorStyle,
    this.keyboardType,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.errorBorderColor,
    this.maxLines,
    this.maxLength,
    this.inputFormatters,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _isControllerExternal = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isControllerExternal = true;
    } else {
      _controller = TextEditingController(text: widget.value ?? '');
    }
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isControllerExternal && widget.value != oldWidget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    if (!_isControllerExternal) {
      _controller.dispose();
    }
    super.dispose();
  }

  String _filterNumericOnly(String text) {
    return text.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _filterDecimalOnly(String text) {
    String filtered = text.replaceAll(RegExp(r'[^0-9.]'), '');
    final parts = filtered.split('.');
    if (parts.length > 2) {
      filtered = '${parts[0]}.${parts.sublist(1).join()}';
    }
    if (parts.length == 2 && parts[1].length > 2) {
      filtered = '${parts[0]}.${parts[1].substring(0, 2)}';
    }
    return filtered;
  }

  // String _filterNumericWithNegative(String text, {bool allowDecimal = false}) {
  //   String pattern = allowDecimal ? r'[^0-9.-]' : r'[^0-9-]';
  //   String filtered = text.replaceAll(RegExp(pattern), '');

  //   if (filtered.indexOf('-') > 0) {
  //     filtered = filtered.replaceAll('-', '');
  //   }

  //   if (allowDecimal) {
  //     final parts = filtered.split('.');
  //     if (parts.length > 2) {
  //       filtered = '${parts[0]}.${parts.sublist(1).join()}';
  //     }
  //   }

  //   return filtered;
  // }

  void _handleTextChange(String text) {
    String filteredText = text;

    if (widget.keyboardType != null) {
      final numericTypes = [
        TextInputType.number,
        TextInputType.phone,
      ];

      final isNumeric = numericTypes.contains(widget.keyboardType) ||
          widget.keyboardType == const TextInputType.numberWithOptions(
                decimal: true,
              );

      if (isNumeric) {
        if (widget.keyboardType ==
            const TextInputType.numberWithOptions(decimal: true)) {
          filteredText = _filterDecimalOnly(text);
        } else {
          filteredText = _filterNumericOnly(text);
        }
      }
    }

    _controller.text = filteredText;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: filteredText.length),
    );

    if (widget.onChangeText != null) {
      widget.onChangeText!(filteredText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error != null && widget.error!.isNotEmpty;
    final effectiveOpacity = widget.disabled ? widget.opacity : 1.0;
    final effectiveBorderRadius = widget.borderRadius ?? 10.0;
    final effectiveBorderColor = hasError
        ? (widget.errorBorderColor ?? Colors.red)
        : (widget.borderColor ?? Colors.grey);
    final effectivePadding = widget.padding ?? const EdgeInsets.symmetric(horizontal: 10.0);

    return Opacity(
      opacity: effectiveOpacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          if (widget.labelComponent != null)
            widget.labelComponent!
          else if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
              child: RichText(
                text: TextSpan(
                  style: widget.additionalLabelStyle ??
                      const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                  children: [
                    TextSpan(text: widget.label),
                    if (widget.showStar)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),

          // Input Container
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: effectiveBorderColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
            child: Row(
              children: [
                // Left Icon
                if (widget.leftIcon != null)
                  GestureDetector(
                    onTap: widget.onPressLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: widget.leftIcon!,
                    ),
                  ),

                // Input Field
                Expanded(
                  child: widget.inputComponent ??
                      TextField(
                        controller: _controller,
                        style: widget.inputStyle ??
                            TextStyle(
                              fontSize: 16,
                              color: hasError ? Colors.black : Colors.black,
                            ),
                        decoration: InputDecoration(
                          hintText: widget.placeholder,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: effectivePadding,
                          isDense: true,
                          constraints: const BoxConstraints(
                            minHeight: 45.0,
                          ),
                        ),
                        onChanged: _handleTextChange,
                        obscureText: widget.secureTextEntry,
                        enabled: !widget.disabled,
                        keyboardType: widget.keyboardType,
                        maxLines: widget.maxLines ?? 1,
                        maxLength: widget.maxLength,
                        inputFormatters: widget.inputFormatters,
                      ),
                ),

                // Right Icon
                if (widget.rightIcon != null)
                  GestureDetector(
                    onTap: widget.onPressRight,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: widget.rightIcon!,
                    ),
                  ),
              ],
            ),
          ),

          // Error Message
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 16,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.error!,
                      style: widget.errorStyle ??
                          const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

