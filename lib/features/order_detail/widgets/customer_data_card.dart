import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/order_detail/order_detail_view_model.dart';

class CustomerDataCard extends StatelessWidget {
  const CustomerDataCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<OrderDetailViewModel>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Datos del cliente',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: hp(1)),
                  Text(_viewModel.fullOrder.customer),
                  Text(_viewModel.fullOrder.contactNumber),
                ],
              ),
            ),
            ElasticIn(
              delay: Duration(milliseconds: 400),
              child: IconButton(
                onPressed: () async => _viewModel.makePhoneCall(),
                icon: Icon(Icons.call,
                    color: AmadisColors.primaryColor, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
