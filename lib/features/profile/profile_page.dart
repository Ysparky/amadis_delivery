import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = SharedPrefs();
    return Scaffold(
      backgroundColor: AmadisColors.primaryColor,
      appBar: CustomAppBar(
        headerTitle: '',
        headerActions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _prefs.removeAll();
              ExtendedNavigator.root.popAndPush(Routes.loginPage);
            },
          )
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          height: hp(100),
          width: wp(100),
          color: Color(0xffF6F6F6),
          child: Center(
            child: Image.asset(AmadisAssets.logo),
          ),
        ),
      ),
    );
  }
}
