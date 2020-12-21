import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/config/colors.dart';

class PricesRow extends StatelessWidget {
  const PricesRow({
    Key key,
    @required this.text,
    @required this.value,
  }) : super(key: key);

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            '$text :',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: AmadisColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
