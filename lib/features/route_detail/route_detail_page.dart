import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouteDetailViewModel()),
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
          steps: [
            Step(
              content: Container(),
              title: OrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
            Step(
              content: Container(),
              title: InactiveOrderItem(),
            ),
          ],
        ),
      ),
    );
  }
}

class InactiveOrderItem extends StatelessWidget {
  const InactiveOrderItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: hp(1.5),
          horizontal: wp(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mi Casita Lt. 4 Los Huertos de Pro Comitas',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: hp(0.5)),
                  Text(
                    'Calidtas JHos',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              width: wp(3),
              height: hp(2),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: hp(1.5),
          horizontal: wp(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Mi Casita Lt. 4 Los Huertos de Pro Comitas eie Jajaj xdxd asdsad',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: hp(0.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Calidtas JHos',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.orange[400],
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: hp(0.5),
                          horizontal: wp(2),
                        ),
                        child: Text(
                          'Consignación',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: wp(0.5)),
            IconButton(
              icon: Icon(Icons.visibility),
              padding: EdgeInsets.zero,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
