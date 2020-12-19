import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/responsive.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    this.headerActions,
    this.headerTitle,
  }) : super(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: hp(8),
          title: Text(headerTitle),
          actions: headerActions,
        );

  final List<Widget> headerActions;
  final String headerTitle;
}
