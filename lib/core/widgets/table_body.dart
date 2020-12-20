import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/models/order_detail.dart';

class TableBody extends StatelessWidget {
  const TableBody({
    Key key,
    @required this.detail,
  }) : super(key: key);

  final OrderDetail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hp(1.0)),
      child: Row(
        children: [
          Expanded(
            child: Text(detail.product.name, textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text('${detail.quantity}', textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text(detail.product.price.toStringAsFixed(2),
                textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text(detail.totalPrice.toStringAsFixed(2),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
