import 'package:amadis_delivery/models/order.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:amadis_delivery/core/utils/utils.dart';

class OrderCardItem extends StatelessWidget {
  const OrderCardItem({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(0.8)),
      elevation: 2.0,
      child: MaterialButton(
        onPressed: () => ExtendedNavigator.root.push(
          Routes.orderDetailPage,
          arguments: OrderDetailPageArguments(order: order),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: hp(1)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '22\nkm',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: wp(2)),
              Expanded(
                flex: 8,
                child: _TextColumn(order: order),
              ),
              Expanded(child: Icon(Icons.navigate_next)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  const _TextColumn({
    Key key,
    this.order,
  }) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pedido #${order.id} - ${orderTypes.singleWhere((element) => element.id == order.orderTypeId).name}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          '${order.location.address}',
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${order.customer}',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
