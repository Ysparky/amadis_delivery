import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/utils.dart';

class EditMissingBoxQuantity extends StatelessWidget {
  const EditMissingBoxQuantity({
    Key key,
    @required this.missingBoxQty,
    @required this.onAddQuantity,
    @required this.onRemoveQuantity,
  }) : super(key: key);

  final int missingBoxQty;
  final Function onAddQuantity;
  final Function onRemoveQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wp(3)),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: wp(3)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20.0),
            right: Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                constraints: BoxConstraints.tight(Size(wp(10), hp(5))),
                color: AmadisColors.primaryColor,
                icon: Icon(Icons.remove),
                iconSize: 22.0,
                padding: EdgeInsets.all(0),
                splashRadius: hp(5),
                onPressed: onRemoveQuantity,
              ),
            ),
            Expanded(child: Center(child: Text('$missingBoxQty'))),
            Expanded(
              child: IconButton(
                constraints: BoxConstraints.tight(Size(wp(10), hp(4))),
                color: AmadisColors.primaryColor,
                icon: Icon(Icons.add),
                iconSize: 22.0,
                padding: EdgeInsets.all(0),
                splashRadius: hp(5),
                onPressed: onAddQuantity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
