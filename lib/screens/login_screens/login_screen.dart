import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../routes/app_routes.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            const Image(image: AssetImage("assets/loginbg.png")),

            Positioned(
              top: 0,
              left: 0,
              child: Image(height: 180, image: AssetImage("assets/circle2.png")),
            ),
            Positioned(
              top: 0,
              left: 100,
              child: Image(height: 180, image: AssetImage("assets/circle2.png")),
            ),
            Positioned(
              top: 0,
              left: 200,
              child: Image(height: 180, image: AssetImage("assets/circle2.png")),
            ),

            Positioned(
              top: 180,
              left: 0,
              child: Image(height: 180, image: AssetImage("assets/circle.png")),
            ),
            Positioned(
              top: 180,
              left: 100,
              child: Image(height: 180, image: AssetImage("assets/circle.png")),
            ),
            Positioned(
              top: 180,
              left: 200,
              child: Image(height: 180, image: AssetImage("assets/circle.png")),
            ),

            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image(height: 180, image: AssetImage("assets/logo.png")),
            ),

            Positioned(
              top: 360,  // You can adjust this value depending on how much space you want
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height - 360, // Adjust dynamically
                decoration: BoxDecoration(
                  color: Color(0xff114b55),
                  borderRadius: BorderRadius.circular(30),
                  border: Border(
                    top: BorderSide(width: 3,),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
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
                        Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: controller.emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.teal.shade700,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                              () => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.rememberMe.value,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.teal.shade700,
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.rememberMe.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  controller.toggleRememberMe(
                                      !controller.rememberMe.value);
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.toggleRememberMe(value);
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.teal.shade900,
                        )),
                        Text(
                          'Remember me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.NewsfeedScreen);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.teal.shade900),
                      ),
                    ),
                    SizedBox(height: 20),
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
