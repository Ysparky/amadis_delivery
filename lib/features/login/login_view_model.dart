import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import 'package:amadis_delivery/core/config/view_model.dart';
import 'package:amadis_delivery/core/utils/constants.dart';
import 'package:amadis_delivery/core/utils/service_injector.dart';
import 'package:amadis_delivery/services/auth_service.dart';

class LoginViewModel extends AmadisViewModel {
  LoginViewModel();

  final _authService = injector<AuthService>();

  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  bool _visiblePassword = false;
  bool get visiblePassword => _visiblePassword;

  final _loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginKey => _loginKey;

  void togglePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  String emailValidator(String email) {
    final isValid = RegExp(emailRegex).hasMatch(email);
    if (email.isEmpty) {
      return 'El correo no puee estar vacío';
    } else if (!isValid) {
      return 'Asegúrese de haber ingresado un correo';
    } else {
      return null;
    }
  }

  String passwordValidator(String password) {
    return password.isEmpty ? 'La contraseña no puede estar vacía' : null;
  }

  void login() async {
    var isFormValid = _loginKey.currentState.validate();
    if (isFormValid) {
      setLoading(true);
      final email = _emailController.value.text;
      final password = _passwordController.value.text;
      final user = await _authService.requestLogin(email, password);
      setLoading(false);
      await _handleLoginResponse(user);
    } else {
      showErrorSnackBar('¡Verifique que no tenga errores!');
    }
  }

  void _handleLoginResponse(dynamic user) async {
    if (user != null) {
      showMessageSnackBar('¡Logueo existoso!');
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => ExtendedNavigator.root.popAndPush('/home-page'));
    } else {
      showErrorSnackBar('Correo y/o contraseña incorrectos');
    }
  }
}
