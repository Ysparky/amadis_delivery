import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmadisColors.primaryColor,
      appBar: CustomAppBar(headerTitle: 'Home'),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          height: hp(100),
          width: wp(100),
          color: AmadisColors.backgroundColor,
          child: IconButton(
            onPressed: () => ExtendedNavigator.root.push(Routes.routesPage),
            icon: Icon(Icons.refresh),
          ),
          // child: Center(
          //   child: Image.asset(AmadisAssets.logo),
          // ),
        ),
      ),
    );
  }
}
