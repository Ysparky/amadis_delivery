import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/routes/routes_view_model.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteItem extends StatelessWidget {
  const RouteItem({
    Key key,
    @required this.selectedOrder,
    this.index,
  }) : super(key: key);

  final int index;
  final MyRoute selectedOrder;
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RoutesViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: wp(5),
        vertical: hp(1),
      ),
      child: Card(
        elevation: hp(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          onPressed: () => _viewModel.goToDetail(selectedOrder, index),
          padding: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: hp(3),
              horizontal: wp(5),
            ),
            child: Row(
              children: [
                Icon(Icons.local_shipping),
                SizedBox(width: wp(5)),
                Column(
                  children: [
                    Text(
                      'Ruta ${index + 1}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: hp(1)),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: _viewModel.getColorRoutebyState(selectedOrder),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: hp(0.5),
                        horizontal: wp(2),
                      ),
                      child: Text(
                        _viewModel.getRouteState(selectedOrder),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: wp(5)),
                Column(
                  children: [
                    Text(
                      'Num Pedidos',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey[600]),
                    ),
                    SizedBox(height: hp(1)),
                    Text(
                      '${selectedOrder.orders.length}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.navigate_next),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
