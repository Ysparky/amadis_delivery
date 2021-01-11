import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/utils.dart';

class CustomModal extends StatelessWidget {
  const CustomModal({
    Key key,
    @required this.child,
    this.onTap,
    this.showCloseButton = true,
  }) : super(key: key);
  final Widget child;
  final bool showCloseButton;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 18.0),
              margin: EdgeInsets.only(top: 13.0, right: 8.0),
              constraints: BoxConstraints(minHeight: hp(20), minWidth: wp(80)),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
            if (showCloseButton)
              Positioned(
                right: 0.0,
                child: GestureDetector(
                  onTap: onTap,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: AmadisColors.primaryColor,
                      child: GestureDetector(
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
