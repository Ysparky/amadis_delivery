import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/list_orders/list_orders_view_model.dart';
import 'package:amadis_delivery/features/list_orders/widgets/widgets.dart';
import 'package:amadis_delivery/models/models.dart';

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
      appBar: CustomAppBar(headerTitle: 'LISTA DE PEDIDOS'),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          height: hp(100),
          width: wp(100),
          color: AmadisColors.backgroundColor,
          child: Column(
            children: [
              Container(
                height: hp(7),
                width: double.infinity,
                margin: EdgeInsets.only(top: hp(1)),
                child: ListView.builder(
                  padding: EdgeInsets.only(left: wp(2), right: wp(2)),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: _viewModel.ordersState.length,
                  itemBuilder: (BuildContext context, int index) {
                    final state = _viewModel.ordersState[index];
                    return OrderStateItem(state: state);
                  },
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _viewModel.orderService
                      .getOrders(stateId: _viewModel.activeState.id),
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
                              : Padding(
                                  padding: EdgeInsets.only(top: hp(1)),
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: hp(5)),
                                    physics: AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    itemCount: orders.length,
                                    itemBuilder: (_, index) =>
                                        OrderCardItem(order: orders[index]),
                                  ),
                                ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStateItem extends StatelessWidget {
  const OrderStateItem({
    Key key,
    @required this.state,
  }) : super(key: key);

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ListOrdersViewModel>(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: hp(1),
        horizontal: wp(2),
      ),
      decoration: BoxDecoration(
        color: state.selected ? AmadisColors.primaryColor : Colors.white,
        border: Border.all(
          color: !state.selected ? AmadisColors.primaryColor : Colors.white,
        ),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(60.0),
          right: Radius.circular(60.0),
        ),
      ),
      child: MaterialButton(
        onPressed: () => _viewModel.handleTap(state),
        shape: StadiumBorder(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(1)),
          child: Center(
            child: Text(
              state.name,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: !state.selected
                      ? AmadisColors.primaryColor
                      : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
