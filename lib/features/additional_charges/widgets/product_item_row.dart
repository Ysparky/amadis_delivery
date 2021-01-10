import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/features/additional_charges/consignment_order/consignment_order_view_model.dart';
import 'package:amadis_delivery/features/additional_charges/widgets/widgets.dart';

class ProductItemRow extends StatelessWidget {
  const ProductItemRow({Key key, this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ConsignmentOrderViewModel>(context);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ProductDataItem(
            orderDetail: _viewModel.order.ordersDetail[index],
          ),
        ),
        Expanded(
          flex: 3,
          child: EditMissingBoxQuantity(
            onAddQuantity: () => _viewModel.editConsumedBoxes(
              _viewModel.consumedList[index].quantity + 1,
              index,
            ),
            onRemoveQuantity: () => _viewModel.editConsumedBoxes(
              _viewModel.consumedList[index].quantity - 1,
              index,
            ),
            missingBoxQty: _viewModel.consumedList[index].quantity,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            _viewModel.consumedList[index].totalPrice.toStringAsFixed(2),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
