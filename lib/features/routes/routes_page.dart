import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
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
        child: RoutesPageBase(),
      ),
    );
  }
}

class RoutesPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RoutesViewModel>(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      backgroundColor: AmadisColors.primaryColor,
      appBar: CustomAppBar(headerTitle: 'Mis Rutas'),
      body: Container(
        color: AmadisColors.backgroundColor,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: hp(2)),
          physics: BouncingScrollPhysics(),
          itemCount: 4,
          itemBuilder: (_, index) => RouteItem(),
        ),
      ),
    );
  }
}

class RouteItem extends StatelessWidget {
  const RouteItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RoutesViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: wp(5),
        vertical: hp(1),
      ),
      child: Card(
        elevation: hp(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          onPressed: _viewModel.goToDetail,
          padding: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: hp(3),
              horizontal: wp(5),
            ),
            child: Row(
              children: [
                Icon(Icons.local_shipping),
                SizedBox(width: wp(5)),
                Column(
                  children: [
                    Text(
                      'Ruta 1',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '01/01/2000',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(width: wp(5)),
                Column(
                  children: [
                    Text(
                      'Num Pedidos',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey[600]),
                    ),
                    Text(
                      '8',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.navigate_next),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
