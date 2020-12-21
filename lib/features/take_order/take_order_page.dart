import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';
import 'package:amadis_delivery/core/widgets/location_form_field/location_form_field.dart';
import 'package:amadis_delivery/features/take_order/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/features/take_order/take_order_view_model.dart';

class TakeOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TakeOrderViewModel()),
      ],
      child: LoadingOverlay<TakeOrderViewModel>(
        child: TakeOrderPageBase(),
      ),
    );
  }
}

class TakeOrderPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<TakeOrderViewModel>(context);
    final _node = FocusScope.of(context);
    return Scaffold(
      appBar: CustomAppBar(headerTitle: 'TOMAR PEDIDO'),
      backgroundColor: AmadisColors.primaryColor,
      key: _viewModel.scaffoldKey,
      body: GestureDetector(
        onTap: () => _node.unfocus(),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: AmadisColors.backgroundColor,
              constraints: BoxConstraints(minHeight: hp(95)),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
              child: Column(
                children: [
                  TextCardFormField(
                    iconData: Icons.calendar_today,
                    text: 'Fecha de Envío',
                    controller: _viewModel.shippingDateController,
                    onTap: () async => _viewModel.selectDate(context, _node),
                  ),
                  SizedBox(height: hp(2)),
                  DropDownCardFormField(
                    text: 'Tipo de Pedido',
                    items: _viewModel.orderTypeDrowpdown,
                    value: _viewModel.orderTypeDrowpdown.first.value,
                    onChanged: (value) =>
                        _viewModel.orderTypeChanged(value, _node),
                  ),
                  SizedBox(height: hp(2)),
                  TextCardFormField(
                    iconData: Icons.search,
                    text: 'Cliente',
                    controller: _viewModel.selectedCustomerController,
                    onTap: _viewModel.goToSelectCustomer,
                  ),
                  SizedBox(height: hp(2)),
                  LocationFormField(controller: _viewModel.addressController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
