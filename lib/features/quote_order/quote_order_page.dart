import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/quote_order/quote_order_view_model.dart';
import 'package:amadis_delivery/features/quote_order/widgets/widgets.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuoteOrderPage extends StatelessWidget {
  const QuoteOrderPage({
    Key key,
    this.order,
    this.orderDetail,
    this.subtotalPrice,
    this.boxCharges,
    this.bottleCharges,
  }) : super(key: key);

  final Order order;
  final List<OrderDetail> orderDetail;
  final double subtotalPrice;
  final double boxCharges;
  final double bottleCharges;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuoteOrderViewModel(
            order: order,
            consumedList: orderDetail,
            subtotalPrice: subtotalPrice,
            bottleCharges: bottleCharges,
            boxCharges: boxCharges,
          ),
        ),
      ],
      child: LoadingOverlay<QuoteOrderViewModel>(
        child: QuoteOrderPageBase(),
      ),
    );
  }
}

class QuoteOrderPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<QuoteOrderViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(headerTitle: 'COTIZAR PEDIDO'),
      backgroundColor: AmadisColors.primaryColor,
      key: _viewModel.scaffoldKey,
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      children: [
                        OrderDataRow(
                          leftText: 'CLIENTE',
                          rightText: 'TIPO',
                          isHeader: true,
                        ),
                        OrderDataRow(
                          leftText: _viewModel.order.customer,
                          rightText: orderTypes
                              .singleWhere(
                                  (e) => e.id == _viewModel.order.orderTypeId)
                              .description,
                          isHeader: false,
                        ),
                        SizedBox(height: hp(2)),
                        OrderDataRow(
                          leftText: 'FECHA',
                          rightText: 'UBICACIÓN',
                          isHeader: true,
                        ),
                        OrderDataRow(
                          leftText: _viewModel.order.shippingDate,
                          rightText: _viewModel.order.location.address,
                          isHeader: false,
                        ),
                        SizedBox(height: hp(2)),
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
                              itemBuilder: (_, index) {
                                final detail =
                                    _viewModel.order.ordersDetail[index];
                                return TableBody(detail: detail);
                              },
                            ),
                          ),
                        ),
                        PricesRow(
                          text: 'Subtotal',
                          value: 'S/. ' +
                              _viewModel.subtotalPrice.toStringAsFixed(2),
                        ),
                        PricesRow(
                          text:
                              'Cargos adicionales por ${_viewModel.order.missingBottlesQuantity} botellas faltantes',
                          value: 'S/. ' +
                              _viewModel.bottleCharges.toStringAsFixed(2),
                        ),
                        PricesRow(
                          text:
                              'Cargos adicionales por ${_viewModel.order.missingBoxQuantity} cajas faltantes',
                          value:
                              'S/. ' + _viewModel.boxCharges.toStringAsFixed(2),
                        ),
                        Divider(),
                        PricesRow(
                          text: 'Precio Total',
                          value: 'S/. ' +
                              _viewModel.subtotalPrice.toStringAsFixed(2),
                        ),
                        SizedBox(height: hp(5)),
                        CustomButton(
                          onPressed: () async =>
                              _viewModel.postAdditionalCharges(),
                          text: 'ENVIAR PEDIDO',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
