import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/order_detail/widgets/widgets.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/features/order_detail/order_detail_view_model.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    Key key,
    this.order,
  }) : super(key: key);

  final Order order;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => OrderDetailViewModel(order: order)),
      ],
      child: LoadingOverlay<OrderDetailViewModel>(
        child: OrderDetailPageBase(),
      ),
    );
  }
}

class OrderDetailPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<OrderDetailViewModel>(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffF6F6F6),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFloatingButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: _viewModel.goBack,
            ),
            CustomFloatingButton(
              icon: Icon(Icons.near_me_rounded),
              onPressed: () => _viewModel.goToMap(context),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _viewModel.getOrderDetailById(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: _viewModel.fullOrder != null
                ? BuildOrderDetail()
                : BuildLoaderShimmer(),
          );
        },
      ),
    );
  }
}
