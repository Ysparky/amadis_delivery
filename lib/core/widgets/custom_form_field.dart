import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/colors.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key key,
    this.autoFocus = false,
    this.bordered = false,
    this.errorText,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.onFIeldSubmitted,
    this.onEditingComplete,
    this.validator,
    TextEditingController textController,
    @required this.hintText,
    @required this.suffixIcon,
  })  : textController = textController ?? TextEditingController(text: ''),
        super(key: key);

  final bool autoFocus;
  final bool bordered;
  final String errorText;
  final String hintText;
  final int maxLines;
  final bool obscureText;
  final Function onChanged;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextEditingController textController;
  final TextInputAction textInputAction;
  final Function(String) onFIeldSubmitted;
  final Function() onEditingComplete;
  final Function(String) validator;

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
      controller: textController
        ..selection = TextSelection.collapsed(
          offset: textController.value.text.length,
        ),
      keyboardType: textInputType,
      maxLines: maxLines,
      obscureText: obscureText,
      onChanged: onChanged,
      textAlign: TextAlign.start,
      textInputAction: textInputAction,
      onFieldSubmitted: onFIeldSubmitted,
      onEditingComplete: onEditingComplete,
      validator: validator,
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
