import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amadis_delivery/core/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = SharedPrefs();
  await preferences.initPrefs();
  preferences.activeRouteIndex = -1;
  startServiceInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ExtendedNavigator<CustomRouter>(router: CustomRouter()),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('es')],
      theme: ThemeData.light().copyWith(
        primaryColor: AmadisColors.primaryColor,
        colorScheme: ColorScheme.light().copyWith(
          primary: AmadisColors.primaryColor,
          onSecondary: Colors.white,
        ),
        textTheme: GoogleFonts.oxygenTextTheme(),
      ),
      title: 'Amadis - Repartidor',
    );
  }
}
