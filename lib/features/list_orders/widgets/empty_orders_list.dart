import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/list_orders/list_orders_view_model.dart';

class EmptyOrdersList extends StatelessWidget {
  const EmptyOrdersList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ListOrdersViewModel>(context);
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AmadisAssets.empty_box,
                fit: BoxFit.cover,
                height: hp(30),
              ),
              SizedBox(height: hp(2)),
              Text(
                'LISTA VACÍA',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: hp(3)),
              Text(
                'No hay pedidos ${_viewModel.activeState.name.toLowerCase()}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: hp(3)),
              MaterialButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Refrescar'),
                ),
                color: AmadisColors.secondaryColor,
                onPressed: () => _viewModel.orderService
                    .getOrders(stateId: _viewModel.activeState.id),
                shape: StadiumBorder(),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
