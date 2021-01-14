import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_view_model.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteDetailPage extends StatelessWidget {
  const RouteDetailPage({
    Key key,
    this.selectedRoute,
  }) : super(key: key);

  final MyRoute selectedRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RouteDetailViewModel(selectedRoute),
        ),
      ],
      child: LoadingOverlay<RouteDetailViewModel>(
        child: RouteDetailPageBase(),
      ),
    );
  }
}

class RouteDetailPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RouteDetailViewModel>(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      backgroundColor: AmadisColors.primaryColor,
      appBar: CustomAppBar(headerTitle: 'Lista de Pedidos'),
      body: Container(
        color: AmadisColors.backgroundColor,
        height: hp(100),
        width: wp(100),
        padding: EdgeInsets.only(top: hp(2)),
        child: Stepper(
          onStepContinue: () => print('asdadasdasd'),
          physics: BouncingScrollPhysics(),
          controlsBuilder: (_, {onStepCancel, onStepContinue}) => Container(),
          steps: _viewModel.stepsList,
          currentStep: _viewModel.currentStep,
          // onStepTapped: _viewModel.onStepTapped,
        ),
      ),
    );
  }
}
