import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/order_detail/order_detail_view_model.dart';

class OrderDataCard extends StatelessWidget {
  const OrderDataCard({Key key}) : super(key: key);

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
            Text(
              'Datos del pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hp(1)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(order.location.address)),
                const SizedBox(width: 10.0),
                Text(order.shippingDate, textAlign: TextAlign.right),
              ],
            ),
            SizedBox(height: hp(1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text((order.location.reference == null ||
                          order.location.reference.isEmpty)
                      ? 'No hay referencia especificada'
                      : order.location.reference),
                ),
                Text(
                  orderStates
                      .singleWhere(
                          (element) => element.id == order.orderStateId)
                      .name,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
