import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/order_detail/order_detail_view_model.dart';

class OrderDetailCard extends StatelessWidget {
  OrderDetailCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderDetailViewModel>(context).fullOrder;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalle',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: hp(1.0)),
                    Text(orderTypes
                        .singleWhere((oT) => oT.id == order.orderStateId)
                        .name),
                  ],
                ),
                ElasticIn(
                  delay: Duration(milliseconds: 400),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      order.orderTypeId == 1
                          ? 'cash_order'
                          : 'consignment_order',
                      arguments: order,
                    ),
                    icon: Icon(Icons.request_quote_rounded,
                        color: AmadisColors.primaryColor, size: 30),
                  ),
                ),
              ],
            ),
            SizedBox(height: hp(1.0)),
            // CustomOrderDetailTable(ordersDetail: order.ordersDetail),
          ],
        ),
      ),
    );
  }
}
