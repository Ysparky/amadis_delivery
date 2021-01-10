import 'package:flutter/material.dart';
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
              Image.asset(
                AmadisAssets.emptyBox,
                fit: BoxFit.cover,
                color: AmadisColors.primaryColor,
                height: hp(20),
              ),
              SizedBox(height: hp(2)),
              Text(
                'LISTA VACÍA',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'No hay pedidos ${_viewModel.activeState.name.toLowerCase()}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
