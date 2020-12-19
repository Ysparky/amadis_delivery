import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/config/colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key key,
    this.autoFocus = false,
    this.bordered = false,
    this.errorText,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.textInputType = TextInputType.text,
    @required this.hintText,
    @required this.suffixIcon,
  }) : super(key: key);

  final bool autoFocus;
  final bool bordered;
  final String errorText;
  final String hintText;
  final int maxLines;
  final bool obscureText;
  final Function onChanged;
  final Widget suffixIcon;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final _errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: errorText == ''
            ? AmadisColors.primaryColor
            : AmadisColors.errorColor,
      ),
    );

    final _normalBorder = bordered
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AmadisColors.primaryColor),
          )
        : InputBorder.none;

    return TextFormField(
      autofocus: autoFocus,
      keyboardType: textInputType,
      maxLines: maxLines,
      obscureText: obscureText,
      onChanged: onChanged,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        errorText: errorText,
        hintText: hintText,
        isDense: true,
        suffixIcon: suffixIcon,
        border: _normalBorder,
        enabledBorder: _normalBorder,
        focusedBorder: _normalBorder,
        errorBorder: _errorBorder,
        focusedErrorBorder: _errorBorder,
      ),
    );
  }
}
