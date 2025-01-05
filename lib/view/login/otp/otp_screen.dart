import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:test/const.dart';
import 'package:test/controller/login_controller.dart';
import 'package:test/view/home/home_screen.dart';
import 'package:test/view/login/widgets/input_field.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  // final String email;
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(
                'assets/lottie/otp.json',
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.fill,
              ),
            ),
          ),
          kheight20,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verify OTP',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          kheight10,
          Form(
            key: formKey,
            child: Column(
              children: [
                InputField(
                  controller: otpController,
                  title: 'OTP',
                  hint: 'Enter the OTP sent to your mail',
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter the OTP';
                  //   }
                  //   if (value.length != 6) {
                  //     return 'OTP should be 6 digits';
                  //   }
                  //   return null;
                  // },
                ),
              ],
            ),
          ),
          kheight10,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.verifyOtp(otpController.text).then((isVerified) {
                      if (isVerified) {
                        Get.snackbar('Success', 'OTP Verified');
                        Get.offAll(HomeScreen());
                      } else {
                        Get.snackbar('Error', 'Invalid OTP');
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kblue,
                ),
                child: GetBuilder<LoginController>(builder: (controller) {
                  return controller.isLoading
                      ? CircularProgressIndicator(color: kwhite)
                      : Text(
                          'Verify OTP',
                          style: TextStyle(color: kwhite),
                        );
                }),
              )),
        ],
      ),
    );
  }
}
