import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/routes/widgets/empty_routes.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/networking/api_response.dart';
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
      appBar: CustomAppBar(
        headerTitle: 'MIS RUTAS',
        headerActions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: _viewModel.goToOrders,
          )
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          color: AmadisColors.backgroundColor,
          child: RefreshIndicator(
            onRefresh: _viewModel.orderService.getRoutes,
            color: AmadisColors.secondaryColor,
            child: StreamBuilder<ApiResponse<List<MyRoute>>>(
              stream: _viewModel.orderService.routes,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case Status.COMPLETED:
                      return snapshot.data.data.isEmpty
                          ? EmptyRoutes()
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: hp(2)),
                              physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (_, index) => RouteItem(
                                selectedOrder: snapshot.data.data[index],
                                index: index,
                              ),
                            );
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: _viewModel.orderService.getRoutes,
                      );
                      break;
                    default:
                      return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RouteItem extends StatelessWidget {
  const RouteItem({
    Key key,
    @required this.selectedOrder,
    this.index,
  }) : super(key: key);

  final int index;
  final MyRoute selectedOrder;
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
          onPressed: () => _viewModel.goToDetail(selectedOrder, index),
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
                      'Ruta ${index + 1}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: hp(1)),
                    Text(
                      '${selectedOrder.orders.first.shippingDate}',
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
                    SizedBox(height: hp(1)),
                    Text(
                      '${selectedOrder.orders.length}',
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
