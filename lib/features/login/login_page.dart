import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
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
    final _node = FocusScope.of(context);
    final _viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(8)),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: hp(100)),
            child: IntrinsicHeight(
              child: GestureDetector(
                onTap: () => _node.unfocus(),
                child: Form(
                  key: _viewModel.loginKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              textController: _viewModel.emailController,
                              hintText: 'Correo Electrónico',
                              suffixIcon: Icon(Icons.alternate_email),
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => _node.nextFocus(),
                              validator: _viewModel.emailValidator,
                            ),
                            SizedBox(height: hp(1.5)),
                            CustomFormField(
                              bordered: true,
                              textController: _viewModel.passwordController,
                              hintText: 'Contraseña',
                              obscureText: !_viewModel.visiblePassword,
                              suffixIcon: IconButton(
                                icon: _viewModel.visiblePassword
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: _viewModel.togglePassword,
                              ),
                              textInputType: TextInputType.visiblePassword,
                              onFIeldSubmitted: (_) => _viewModel.login(),
                              validator: _viewModel.passwordValidator,
                            ),
                            SizedBox(height: hp(3)),
                            CustomButton(
                              onPressed: _viewModel.login,
                              text: 'LOGIN',
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
