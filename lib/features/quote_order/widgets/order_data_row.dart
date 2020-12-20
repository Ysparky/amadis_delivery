import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/features/quote_order/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OrderDataRow extends StatelessWidget {
  const OrderDataRow({
    Key key,
    @required this.leftText,
    @required this.rightText,
    this.isHeader = false,
  }) : super(key: key);

  final bool isHeader;
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: hp(0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ExpandedText(keyText: leftText, isHeader: isHeader),
          ExpandedText(keyText: rightText, isHeader: isHeader),
        ],
      ),
    );
  }
}
