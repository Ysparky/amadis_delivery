import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';

class OrderDataCard extends StatelessWidget {
  const OrderDataCard({
    Key key,
    this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hp(1)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    order.location.address,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  order.shippingDate ?? 'No registra fecha de envio',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(height: hp(1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    (order.location.reference == null ||
                            order.location.reference.isEmpty)
                        ? 'No hay referencia especificada'
                        : order.location.reference,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Text(
                  orderStates
                      .singleWhere(
                          (element) => element.id == order.orderStateId)
                      .name,
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
