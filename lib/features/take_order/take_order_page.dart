import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/loading_overlay.dart';
import 'package:amadis_delivery/features/take_order/take_order_view_model.dart';

class TakeOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TakeOrderViewModel()),
      ],
      child: LoadingOverlay<TakeOrderViewModel>(
        child: TakeOrderPageBase(),
      ),
    );
  }
}

class TakeOrderPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
