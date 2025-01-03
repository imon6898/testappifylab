import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  // TextEditingControllers for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var rememberMe = false.obs;

  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
    }
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is destroyed
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
