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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: hp(1)),
      child: Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () => _viewModel.goToDetail(order),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: order.orderTypeId == 1
                        ? Colors.cyan
                        : Colors.orange[400],
                    width: wp(3.5)),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: hp(1.5),
                horizontal: wp(1),
              ),
              child: Row(
                children: [
                  Icon(Icons.directions),
                  SizedBox(width: wp(1.5)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'En progreso:',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          order.location.address,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: hp(0.5)),
                        order.orderTypeId == 2
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order.customer,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Container(
                                    height: hp(3),
                                    width: wp(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: order.isDelivery
                                          ? Colors.red
                                          : Colors.teal,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                order.customer,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                      ],
                    ),
                  ),
                  Icon(Icons.navigate_next),
                  SizedBox(width: wp(0.5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
