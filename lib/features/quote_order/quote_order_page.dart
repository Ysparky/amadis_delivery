import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
import 'package:amadis_delivery/features/quote_order/quote_order_view_model.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuoteOrderPage extends StatelessWidget {
  const QuoteOrderPage({
    Key key,
    this.order,
    this.orderDetail,
  }) : super(key: key);

  final Order order;
  final List<OrderDetail> orderDetail;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuoteOrderViewModel(
            order,
            consumedList: orderDetail,
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
    );
  }
}
