import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomTableBody extends StatelessWidget {
  const CustomTableBody({
    Key key,
    @required this.children,
    this.showDivider = true,
  }) : super(key: key);

  final List<Widget> children;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: hp(1.0)),
          child: Row(
            children: children,
          ),
        ),
        showDivider ? Divider(thickness: 1.0) : Container(),
      ],
    );
  }
}
