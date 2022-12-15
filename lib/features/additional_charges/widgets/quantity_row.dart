import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/features/additional_charges/widgets/widgets.dart';

class QuantityRow extends StatelessWidget {
  const QuantityRow({
    Key key,
    @required this.quantity,
    @required this.onAddQuantity,
    @required this.onRemoveQuantity,
  }) : super(key: key);

  final int quantity;
  final Function onAddQuantity;
  final Function onRemoveQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wp(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuantityButton(icon: Icons.remove, onPressed: onRemoveQuantity),
          Expanded(child: Text('$quantity', textAlign: TextAlign.center)),
          QuantityButton(icon: Icons.add, onPressed: onAddQuantity),
        ],
      ),
    );
  }
}
