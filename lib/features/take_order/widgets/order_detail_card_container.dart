import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/take_order/take_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Text(
              'Detalle de Pedido',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: DropdownButtonFormField(
                    items: _viewModel.productsDropdown,
                    value: _viewModel.productsPresentationList.first,
                    onChanged: _viewModel.onChangedProduct,
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: hp(1.2),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  padding: EdgeInsets.all(0),
                  onPressed: _viewModel.removeDetailQuantity,
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _viewModel.editQtyController
                      ..selection = TextSelection.collapsed(
                        offset: _viewModel.editQtyController.text.length,
                      ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: hp(1)),
                      isCollapsed: true,
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: null,
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _viewModel.editDetailQuantity(int.parse(value).abs());
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  padding: EdgeInsets.all(0),
                  onPressed: _viewModel.addDetailQuantity,
                ),
              ],
            ),
            const Divider(thickness: 2.0),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _viewModel.orderDetail.isNotEmpty
                  ? Column(
                      children: [
                        Ink(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
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
                        ..._viewModel.orderDetail
                            .map((detail) => TableBody(detail: detail))
                            .toList(),
                      ],
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(minHeight: hp(9.2)),
                      child: Center(
                        child: Text('No hay productos seleccionados'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
