import 'dart:ui';

class AmadisColors {
  static final AmadisColors _amadisAssets = AmadisColors._internal();

  factory AmadisColors() => _amadisAssets;

  AmadisColors._internal();

  static const primaryColor = Color(0xff053F5E);
  static const secondaryColor = Color(0xff107163);
  static const errorColor = Color(0xFFBD4F53);
  static const backgroundColor = Color(0xffF6F6F6);
}
