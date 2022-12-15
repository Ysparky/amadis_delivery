import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/colors.dart';

class ExpandedText extends StatelessWidget {
  const ExpandedText({
    Key key,
    @required this.keyText,
    @required this.isHeader,
  }) : super(key: key);

  final String keyText;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        keyText,
        textAlign: TextAlign.center,
        style: isHeader
            ? Theme.of(context).textTheme.subtitle1.copyWith(
                  color: AmadisColors.primaryColor,
                  fontWeight: FontWeight.w700,
                )
            : Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
