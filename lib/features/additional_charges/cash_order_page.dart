import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/features/additional_charges/consignment_order_view_model.dart';
import 'package:amadis_delivery/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashOrderPage extends StatelessWidget {
  const CashOrderPage({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConsignmentOrderViewModel(),
        )
      ],
      child: LoadingOverlay<ConsignmentOrderViewModel>(
        child: CashOrderPageBase(),
      ),
    );
  }
}

class CashOrderPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
