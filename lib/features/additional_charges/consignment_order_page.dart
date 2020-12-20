import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'additional_chages_view_model.dart';

class ConsignmentOrderPage extends StatelessWidget {
  const ConsignmentOrderPage({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdditionalChargesViewModel(),
        )
      ],
      child: LoadingOverlay<AdditionalChargesViewModel>(
        child: ConsignmentOrderPageBase(),
      ),
    );
  }
}

class ConsignmentOrderPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
