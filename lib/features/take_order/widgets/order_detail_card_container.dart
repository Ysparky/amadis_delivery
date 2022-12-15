import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/take_order/take_order_view_model.dart';
import 'package:amadis_delivery/models/models.dart';

class OrderDetailCardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<TakeOrderViewModel>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detalle de Pedido',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                FloatingActionButton(
                  mini: true,
                  elevation: 0,
                  backgroundColor: AmadisColors.primaryColor,
                  child: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  onPressed: _viewModel.goToShoppingBag,
                ),
              ],
            ),
            StreamBuilder(
              stream: _viewModel.orderDetail,
              builder: (_, AsyncSnapshot<List<OrderDetail>> snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: snapshot.hasData
                      ? Padding(
                          padding: EdgeInsets.only(top: hp(1)),
                          child: Column(
                            children: [
                              Ink(
                                decoration:
                                    BoxDecoration(color: Colors.indigo[50]),
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
                              ...snapshot.data
                                  .map((detail) => TableBody(detail: detail))
                                  .toList(),
                            ],
                          ),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(minHeight: hp(6.2)),
                          child: Center(
                            child: Text('No hay productos seleccionados'),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
