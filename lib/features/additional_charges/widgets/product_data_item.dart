import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';

class ProductDataItem extends StatelessWidget {
  const ProductDataItem({
    Key key,
    @required this.orderDetail,
  }) : super(key: key);
  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme.subtitle2;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: wp(1.0)),
      child: Column(
        children: [
          Text(
            orderDetail.productPresentation.product.name,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                'Prec. Unit.:',
                style: _textStyle,
              )),
              Expanded(
                  child: Text(
                'S/.' +
                    orderDetail.productPresentation.price.toStringAsFixed(2),
                style: _textStyle,
                textAlign: TextAlign.right,
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                'Cajas Solicitadas:',
                style: _textStyle,
              )),
              Text(
                '${orderDetail.quantity}',
                style: _textStyle,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
