import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/responsive.dart';

class TableHeaderItem extends StatelessWidget {
  TableHeaderItem({
    Key key,
    @required this.text,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(0.5)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      ),
    );
  }
}
