import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/additional_charges/widgets/widgets.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consignment_order_view_model.dart';

class ConsignmentOrderPage extends StatelessWidget {
  const ConsignmentOrderPage({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConsignmentOrderViewModel(orignalOrder: order),
        )
      ],
      child: LoadingOverlay<ConsignmentOrderViewModel>(
        child: ConsignmentOrderPageBase(),
      ),
    );
  }
}

class ConsignmentOrderPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ConsignmentOrderViewModel>(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      appBar: CustomAppBar(headerTitle: 'CARGOS ADICIONALES'),
      backgroundColor: AmadisColors.primaryColor,
      body: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
          color: AmadisColors.backgroundColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(5)),
        child: Column(
          children: [
            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.indigo[50],
              ),
              child: Row(
                children: [
                  TableHeaderItem(text: 'Producto', flex: 3),
                  TableHeaderItem(text: 'Cajas Consumidas', flex: 3),
                  TableHeaderItem(text: 'Subtotal', flex: 2),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: _viewModel.scrollController,
                radius: Radius.circular(5.0),
                thickness: 5.0,
                child: ListView.separated(
                  controller: _viewModel.scrollController,
                  padding: EdgeInsets.only(top: hp(1)),
                  itemCount: _viewModel.order.ordersDetail.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (_, index) => ProductItemRow(index: index),
                ),
              ),
            ),
            PricesRow(
              text: 'Subtotal',
              value: 'S/. ' + _viewModel.subtotalPrice.toStringAsFixed(2),
            ),
            Divider(height: hp(4)),
            Text(
              'ENVASES FALTANTES',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              ' (1 x S/. 1.00) ',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hp(2)),
            QuantityRow(
              quantity: _viewModel.order.missingBottlesQuantity,
              onAddQuantity: () => _viewModel.editMissingBottlesQuantity(
                _viewModel.order.missingBottlesQuantity + 1,
              ),
              onRemoveQuantity: () => _viewModel.editMissingBottlesQuantity(
                _viewModel.order.missingBottlesQuantity - 1,
              ),
            ),
            SizedBox(height: hp(2)),
            Text(
              'CAJAS FALTANTES',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              ' (1 x S/. 4.00) ',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hp(2)),
            QuantityRow(
              quantity: _viewModel.order.missingBoxQuantity,
              onAddQuantity: () => _viewModel.editMissingBoxQuantity(
                _viewModel.order.missingBoxQuantity + 1,
              ),
              onRemoveQuantity: () => _viewModel.editMissingBoxQuantity(
                _viewModel.order.missingBoxQuantity - 1,
              ),
            ),
            SizedBox(height: hp(2)),
            PricesRow(
              text: 'Cargos adicionales por botellas faltantes',
              value: 'S/. ' + _viewModel.bottlesCharges.toStringAsFixed(2),
            ),
            PricesRow(
              text: 'Cargos adicionales por cajas faltantes',
              value: 'S/. ' + _viewModel.boxCharges.toStringAsFixed(2),
            ),
            SizedBox(height: hp(2)),
            CustomButton(
              onPressed: _viewModel.goToQuoteOrder,
              text: 'COTIZAR',
            ),
          ],
        ),
      ),
    );
  }
}
