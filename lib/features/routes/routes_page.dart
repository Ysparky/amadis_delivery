import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/loading_overlay.dart';
import 'package:amadis_delivery/features/routes/routes_view_model.dart';

class RoutesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoutesViewModel()),
      ],
      child: LoadingOverlay<RoutesViewModel>(
        child: RoutesPage(),
      ),
    );
  }
}

class RoutesPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RoutesViewModel>(context);
    return Container();
  }
}
