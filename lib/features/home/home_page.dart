import 'package:amadis_delivery/features/home/home_view_model.dart';
import 'package:amadis_delivery/features/home/widgets/widgets.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/networking/api_response.dart';
import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: LoadingOverlay<HomeViewModel>(child: HomePageBase()),
    );
  }
}

class HomePageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: AmadisColors.primaryColor,
      appBar: CustomAppBar(
        headerTitle: 'Home',
        headerActions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _viewModel.logOut,
          )
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          height: hp(100),
          width: wp(100),
          color: AmadisColors.backgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: wp(4),
            vertical: hp(3),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ..._viewModel.daysOfWeek.asMap().entries.map((e) {
                    final idx = e.key;
                    final dayOfWeek = e.value;
                    return DayIndicator(
                      day: _viewModel.days[idx],
                      dayOfWeek: dayOfWeek,
                      isToday: _viewModel.today == _viewModel.days[idx],
                    );
                  })
                ],
              ),
              Spacer(),
              StreamBuilder<ApiResponse<List<MyRoute>>>(
                stream: _viewModel.myRoutes,
                initialData: ApiResponse.completed([]),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data?.data?.length);
                    return CounterCard(
                      icon: Icons.delivery_dining,
                      qty: _viewModel.routesLeft(snapshot.data.data),
                      description:
                          _viewModel.routesLeft(snapshot.data.data) != 1
                              ? 'Rutas restantes por repartir'
                              : 'Ruta restante por repartir',
                    );
                  } else {
                    return Center(
                      child: LinearProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(height: hp(3)),
              StreamBuilder<ApiResponse<List<MyRoute>>>(
                  stream: _viewModel.myRoutes,
                  initialData: ApiResponse.completed([]),
                  builder: (_, snapshot) {
                    return CounterCard(
                      icon: Icons.ac_unit,
                      qty: _viewModel.ordersDeliveredQty(snapshot.data.data),
                      description:
                          _viewModel.ordersDeliveredQty(snapshot.data.data) != 1
                              ? 'Pedidos entregados'
                              : 'Pedido entregado',
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
