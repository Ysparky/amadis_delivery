import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/utils.dart';

class WelcomePage extends StatelessWidget {
  final _prefs = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: injector.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? WillPopScope(
                onWillPop: () => Future.value(false),
                child: SplashScreen(
                  loaderColor: AmadisColors.primaryColor,
                  image: Image.asset(AmadisAssets.logo),
                  photoSize: wp(40),
                  navigateAfterSeconds: _prefs.isLoggedIn
                      ? Routes.dashboardPage
                      : Routes.loginPage,
                  seconds: 2,
                ),
              )
            : Container(
                color: Colors.blue,
              );
      },
    );
  }
}
