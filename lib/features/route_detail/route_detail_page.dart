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
      body: Ink(
        color: AmadisColors.backgroundColor,
        height: hp(100),
        width: wp(100),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(2)),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: _viewModel.showLegend,
                  icon: Icon(Icons.info),
                ),
              ),
            ),
            Stepper(
              onStepContinue: () => print('asdadasdasd'),
              physics: BouncingScrollPhysics(),
              controlsBuilder: (_, {onStepCancel, onStepContinue}) =>
                  Container(),
              steps: _viewModel.stepsList,
              currentStep: _viewModel.currentStep,
            ),
          ],
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wp(5)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: hp(2)),
        child: Column(
          children: [
            Text(
              'Leyenda',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hp(2)),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contado',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Consignación',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(width: wp(5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleDot(color: Colors.cyan),
                    CircleDot(color: Colors.orange[400]),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entrega',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Recojo',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(width: wp(5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleDot(color: Colors.red),
                    CircleDot(color: Colors.teal),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleDot extends StatelessWidget {
  const CircleDot({
    Key key,
    @required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hp(3),
      width: wp(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
