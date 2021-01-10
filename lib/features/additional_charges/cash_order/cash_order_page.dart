import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/additional_charges/cash_order/cash_order_view_model.dart';
import 'package:amadis_delivery/features/additional_charges/widgets/widgets.dart';

class CashOrderPage extends StatelessWidget {
  const CashOrderPage({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CashOrderViewModel(originalOrder: order),
        )
      ],
      child: LoadingOverlay<CashOrderViewModel>(
        child: CashOrderPageBase(),
      ),
    );
  }
}

class CashOrderPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<CashOrderViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(headerTitle: 'CARGOS ADICIONALES'),
      key: _viewModel.scaffoldKey,
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
              decoration: BoxDecoration(color: Colors.indigo[50]),
              child: Row(
                children: [
                  TableHeaderItem(text: 'Presentación'),
                  TableHeaderItem(text: 'Cantidad\n(cajas)'),
                  TableHeaderItem(text: 'Precio Unit.'),
                  TableHeaderItem(text: 'Subtotal'),
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
                  padding: EdgeInsets.only(top: hp(1.5)),
                  itemCount: _viewModel.order.ordersDetail.length,
                  separatorBuilder: (context, index) => Divider(thickness: 1),
                  itemBuilder: (_, index) {
                    final detail = _viewModel.order.ordersDetail[index];
                    return TableBody(detail: detail);
                  },
                ),
              ),
            ),
            PricesRow(
              text: 'Subtotal',
              value: 'S/. ' + _viewModel.subtotalPrice.toStringAsFixed(2),
            ),
            Divider(height: hp(5)),
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
            PricesRow(
              text: '',
              value: 'S/. ' + _viewModel.bottlesCharges.toStringAsFixed(2),
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
            PricesRow(
              text: '',
              value: 'S/. ' + _viewModel.boxCharges.toStringAsFixed(2),
            ),
            SizedBox(height: hp(5)),
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

class TableBody extends StatelessWidget {
  const TableBody({
    Key key,
    @required this.detail,
  }) : super(key: key);

  final OrderDetail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hp(1.0)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              detail.productPresentation.product.name +
                  ' ' +
                  detail.productPresentation.presentation.name,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('${detail.quantity}', textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text(detail.productPresentation.price.toStringAsFixed(2),
                textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text(detail.totalPrice.toStringAsFixed(2),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
