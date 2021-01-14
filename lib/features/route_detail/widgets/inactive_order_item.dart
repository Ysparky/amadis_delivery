import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/order.dart';
import 'package:flutter/material.dart';

class InactiveOrderItem extends StatelessWidget {
  const InactiveOrderItem({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: hp(1.5),
          horizontal: wp(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.location.address,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: hp(0.5)),
                  Text(
                    order.customer,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              width: wp(3),
              height: hp(2),
              decoration: BoxDecoration(
                color:
                    order.orderTypeId == 1 ? Colors.cyan : Colors.orange[400],
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
