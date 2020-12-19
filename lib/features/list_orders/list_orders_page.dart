import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/config/loading_overlay.dart';
import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
import 'package:amadis_delivery/features/list_orders/list_orders_view_model.dart';
import 'package:amadis_delivery/features/list_orders/widgets/empty_orders_list.dart';
import 'package:amadis_delivery/features/list_orders/widgets/order_card_item.dart';
import 'package:amadis_delivery/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListOrdersViewModel()),
      ],
      child: LoadingOverlay<ListOrdersViewModel>(
        child: ListOrdersPageBase(),
      ),
    );
  }
}

class ListOrdersPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ListOrdersViewModel>(context);
    return Scaffold(
      backgroundColor: AmadisColors.primaryColor,
      key: _viewModel.scaffoldKey,
      appBar: CustomAppBar(
        headerTitle: 'LISTA DE PEDIDOS',
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          height: hp(100),
          width: wp(100),
          color: AmadisColors.backgroundColor,
          child: RefreshIndicator(
            onRefresh: _viewModel.orderService.getOrders,
            color: AmadisColors.secondaryColor,
            child: StreamBuilder(
              stream: _viewModel.orders,
              builder: (_, AsyncSnapshot<List<Order>> snapshot) {
                if (snapshot.hasData) {
                  final orders = snapshot.data;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: snapshot.data.isEmpty
                        ? EmptyOrdersList()
                        : ListView.builder(
                            padding:
                                EdgeInsets.only(top: hp(2.5), bottom: hp(5)),
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: orders.length,
                            itemBuilder: (_, index) =>
                                OrderCardItem(order: orders[index]),
                          ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
