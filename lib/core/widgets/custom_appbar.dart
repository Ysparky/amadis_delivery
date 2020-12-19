import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    this.headerActions,
    this.headerTitle,
  }) : super(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: kToolbarHeight * 1.25,
          title: Text(headerTitle),
          actions: headerActions,
        );

  final List<Widget> headerActions;
  final String headerTitle;
}
