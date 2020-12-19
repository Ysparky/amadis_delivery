import 'package:amadis_delivery/core/config/router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:amadis_delivery/core/config/router.gr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ExtendedNavigator<CustomRouter>(
        router: CustomRouter(),
        initialRoute: '/',
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('es')],
      theme: ThemeData.light().copyWith(
        // primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.light().copyWith(
          // primary: kPrimaryColor,
          onSecondary: Colors.white,
        ),
        textTheme: GoogleFonts.oxygenTextTheme(),
      ),
      title: 'Amadis - Repartidor',
    );
  }
}
