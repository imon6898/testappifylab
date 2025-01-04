import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State Observables
  var isLoading = false.obs;
  var emailError = Rx<String?>(null);
  var passwordError = Rx<String?>(null);
  var obscurePassword = true.obs;

  // API Endpoint
  final String loginUrl = "https://ezycourse.com/api/app/student/auth/login";

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Validate Email
  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Email cannot be empty';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Enter a valid email';
    } else {
      emailError.value = null;
    }
  }

  // Validate Password
  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Password cannot be empty';
    } else {
      passwordError.value = null;
    }
  }

  // Login Function
  Future<void> login() async {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);

    if (emailError.value != null || passwordError.value != null) {
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
          "app_token": "",
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        Get.offAllNamed(AppRoutes.NewsfeedScreen);
      } else {
        Get.snackbar("Login Failed", "Invalid email or password",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
