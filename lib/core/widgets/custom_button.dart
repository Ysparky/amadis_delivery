import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/utils/responsive.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minWidth: double.infinity,
      color: AmadisColors.secondaryColor,
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: hp(1.5)),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
