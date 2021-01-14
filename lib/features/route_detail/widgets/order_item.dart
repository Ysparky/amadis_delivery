import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_view_model.dart';
import 'package:amadis_delivery/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RouteDetailViewModel>(context);
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    order.location.address,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: hp(0.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          order.customer,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: order.orderTypeId == 1
                              ? Colors.cyan
                              : Colors.orange[400],
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: hp(0.5),
                          horizontal: wp(2),
                        ),
                        child: Text(
                          order.orderTypeId == 1 ? 'Contado' : 'Consignación',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: wp(0.5)),
            IconButton(
              icon: Icon(Icons.visibility),
              padding: EdgeInsets.zero,
              onPressed: () => _viewModel.goToDetail(order),
            ),
          ],
        ),
      ),
    );
  }
}
