import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            const Image(image: AssetImage("assets/loginbg.png"), fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image(height: 180, image: AssetImage("assets/logo.png")),
            ),
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height - 300,
                decoration: BoxDecoration(
                  color: const Color(0xff114b55),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: controller.emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.white54),
                            fillColor: Colors.teal.shade700,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            errorText: controller.emailError.value,
                          ),
                          onChanged: controller.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Password",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Obx(
                              () => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword.value,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.white54),
                              fillColor: Colors.teal.shade700,
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              errorText: controller.passwordError.value,
                            ),
                            onChanged: controller.validatePassword,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        controller.isLoading.value ? 'Logging in...' : 'Login',
                        style: TextStyle(color: Colors.teal.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
