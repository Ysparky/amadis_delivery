import 'package:flutter/widgets.dart';

import 'package:amadis_delivery/core/config/view_model.dart';
import 'package:amadis_delivery/core/utils/constants.dart';

class LoginViewModel extends AmadisViewModel {
  LoginViewModel();

  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

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

  void login() {
    var isFormValid = _loginKey.currentState.validate();
    if (isFormValid) {
      print('valid');
    } else {
      print('not valid');
    }
  }
}
