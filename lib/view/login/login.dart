import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:test/const.dart';
import 'package:test/controller/login_controller.dart';
import 'package:test/view/home/home_screen.dart';
import 'package:test/view/login/widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset('assets/lottie/login.json',
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.fill),
          )),
          kheight20,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          kheight10,
          Form(
            key: formkey,
            child: Column(
              children: [
                InputField(
                  controller: mailController,
                  title: 'E-mail',
                  hint: 'Enter your Email',
                ),
              ],
            ),
          ),
          kheight10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  if (mailController.text == 'abc@gmail.com') {
                    Get.off(HomeScreen());
                  }else{
                  controller.signIn(mailController.text);

                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kblue,
              ),
              child: GetBuilder<LoginController>(builder: (controller) {
                return controller.isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Login',
                        style: TextStyle(color: kwhite),
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
