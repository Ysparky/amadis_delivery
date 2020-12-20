import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/order_detail/order_detail_view_model.dart';

class OrderDetailCard extends StatelessWidget {
  OrderDetailCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<OrderDetailViewModel>(context);
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
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: hp(1.0)),
                    Text(
                      orderTypes
                          .singleWhere((oT) =>
                              oT.id == _viewModel.fullOrder.orderStateId)
                          .name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                ElasticIn(
                  delay: Duration(milliseconds: 400),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.request_quote_rounded,
                      color: AmadisColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: hp(1.0)),
            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.indigo[50],
              ),
              child: Row(
                children: [
                  TableHeaderItem(text: 'Producto'),
                  TableHeaderItem(text: 'Cantidad\n(cajas)'),
                  TableHeaderItem(text: 'Precio Unit.'),
                  TableHeaderItem(text: 'Subtotal'),
                ],
              ),
            ),
            SizedBox(height: hp(1.0)),
            ..._viewModel.fullOrder.ordersDetail
                .map((detail) => TableBody(detail: detail))
                .toList(),
            Divider(thickness: 1.0, color: AmadisColors.secondaryColor),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PricesRow(
                text: 'Subtotal',
                value: 'S/. ${_viewModel.getTotalAmount().toStringAsFixed(2)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
