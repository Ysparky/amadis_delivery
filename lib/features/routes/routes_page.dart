import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/routes/widgets/widgets.dart';
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
