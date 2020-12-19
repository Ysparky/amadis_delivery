import 'package:amadis_delivery/core/config/loading_overlay.dart';
import 'package:amadis_delivery/features/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
    );
  }
}
