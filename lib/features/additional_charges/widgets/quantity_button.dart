import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/colors.dart';
import 'package:amadis_delivery/core/utils/responsive.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        decoration: BoxDecoration(
          color: AmadisColors.secondaryColor,
          borderRadius: icon == Icons.add
              ? BorderRadius.horizontal(right: Radius.circular(wp(4)))
              : BorderRadius.horizontal(left: Radius.circular(wp(4))),
        ),
        child: IconButton(
          color: Colors.white,
          constraints: BoxConstraints.tightFor(
            width: wp(8),
            height: hp(4.5),
          ),
          icon: Icon(icon),
          iconSize: 22.0,
          onPressed: onPressed,
          padding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
