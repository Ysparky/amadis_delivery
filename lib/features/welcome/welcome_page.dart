import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:amadis_delivery/core/config/assets.dart';
import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/config/router.gr.dart';
import 'package:amadis_delivery/core/utils/service_injector.dart';
import 'package:amadis_delivery/core/utils/shared_prefs.dart';

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
