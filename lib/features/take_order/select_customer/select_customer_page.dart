import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/take_order/select_customer/select_customer_view_model.dart';
import 'package:amadis_delivery/features/take_order/select_customer/widgets/customer_tile.dart';
import 'package:amadis_delivery/models/customer.dart';

class SelectCustomerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SelectCustomerViewModel(),
        ),
      ],
      child: LoadingOverlay<SelectCustomerViewModel>(
        child: SelectCustomerPageBase(),
      ),
    );
  }
}

class SelectCustomerPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<SelectCustomerViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(headerTitle: 'BUSCAR CLIENTE'),
      backgroundColor: AmadisColors.primaryColor,
      key: _viewModel.scaffoldKey,
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          color: AmadisColors.backgroundColor,
          height: hp(100),
          width: wp(100),
          padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomFormField(
                autoFocus: true,
                bordered: true,
                hintText: 'Buscar Cliente',
                suffixIcon: Icon(Icons.search),
                onChanged: _viewModel.handleCustomerSearch,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _viewModel.customerService.getCustomers,
                  color: AmadisColors.secondaryColor,
                  child: StreamBuilder(
                    stream: _viewModel.filteredList,
                    builder: (_, AsyncSnapshot<List<Customer>> snapshot) {
                      if (snapshot.hasData) {
                        final customers = snapshot.data;
                        return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          padding: EdgeInsets.symmetric(vertical: hp(1)),
                          itemCount: customers.length,
                          itemBuilder: (_, index) =>
                              CustomerTile(customer: customers[index]),
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
