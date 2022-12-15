import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/take_order/select_customer/select_customer_view_model.dart';
import 'package:amadis_delivery/models/customer.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    Key key,
    @required this.customer,
  }) : super(key: key);

  final Customer customer;

  static const roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)));

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<SelectCustomerViewModel>(context);
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(5)),
      shape: roundedRectangleBorder,
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(3)),
        shape: roundedRectangleBorder,
        leading: CircleAvatar(
          child: Icon(Icons.person_outline),
          radius: hp(2.5),
        ),
        title: Text(
          '${customer.name} ${customer.lastName}',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text('${customer.document}'),
        trailing:
            Icon(Icons.arrow_forward_ios, color: AmadisColors.primaryColor),
        onTap: () => _viewModel.selectCustomer(customer),
      ),
    );
  }
}
