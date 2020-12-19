import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/config/assets.dart';
import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/core/widgets/custom_appbar.dart';

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
          color: Color(0xffF6F6F6),
          child: Center(
            child: Image.asset(AmadisAssets.logo),
          ),
        ),
      ),
    );
  }
}
