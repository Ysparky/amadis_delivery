import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/assets.dart';
import 'package:amadis_delivery/core/config/loading_overlay.dart';
import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/core/widgets/custom_button.dart';
import 'package:amadis_delivery/core/widgets/custom_form_field.dart';
import 'package:amadis_delivery/features/login/login_view_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: LoadingOverlay<LoginViewModel>(
        child: LoginPageBase(),
      ),
    );
  }
}

class LoginPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: wp(8)),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: hp(100)),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset(AmadisAssets.logo),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      CustomFormField(
                        bordered: true,
                        hintText: 'Correo Electrónico',
                        suffixIcon: Icon(Icons.alternate_email),
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: hp(1.5)),
                      CustomFormField(
                        bordered: true,
                        hintText: 'Contraseña',
                        obscureText: true,
                        suffixIcon: Icon(Icons.alternate_email),
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: hp(3)),
                      CustomButton(
                        onPressed: () {},
                        text: 'LOGIN',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
