import 'dart:developer'; 
import 'package:get/get.dart'; 
import 'package:email_otp/email_otp.dart'; 
import 'package:test/view/login/otp/otp_screen.dart'; 

class LoginController extends GetxController {
  bool isLoading = false; 

  // Method to handle the sign-in process using an email.
  Future<void> signIn(String email) async {
    try {
      isLoading = true; // Set loading to true before starting the process.
      update(); 

      // Configure the Email OTP package with app-specific settings.
      EmailOTP.config(
        appName: 'Game App', 
        otpType: OTPType.numeric, 
        expiry: 300000, 
        emailTheme: EmailTheme.v6, 
        otpLength: 6, 
      );

      // Attempt to send the OTP to the provided email.
      bool isSent = await EmailOTP.sendOTP(email: email);
      if (isSent) {
        // If OTP is successfully sent, show a success message and navigate to OTP screen.
        Get.snackbar('Success', 'OTP sent to $email');
        Get.to(OTPScreen());
      } else {
        // If sending OTP fails, show an error message.
        Get.snackbar('Error', 'Failed to send OTP. Please try again.');
      }
    } catch (e) {
      // Handle any errors that occur during the process.
      Get.snackbar('Error', 'An error occurred: $e');
      log(e.toString());
    } finally {
      isLoading = false; 
      update(); 
    }
  }

  // Method to verify the OTP entered by the user.
  Future<bool> verifyOtp(String otp) async {
    try {
      isLoading = true; 
      update(); 

      // Verify the OTP using the Email OTP package.
      bool isVerified = EmailOTP.verifyOTP(otp: otp);
      if (isVerified) {
        // If OTP verification is successful, show a success message.
        Get.snackbar('Success', 'OTP verified successfully');
        return true; // Return true indicating successful verification.
      } else {
        // If OTP verification fails, show an error message.
        Get.snackbar('Error', 'Invalid OTP. Please try again.');
        return false; // Return false indicating failed verification.
      }
    } catch (e) {
      // Handle any errors that occur during the verification process.
      Get.snackbar('Error', 'An error occurred: $e');
      log(e.toString()); // Log the error for debugging purposes.
      return false; // Return false due to an error.
    } finally {
      isLoading = false; // Reset the loading state after the process.
      update(); 
    }
  }
}
