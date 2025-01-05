import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:test/const.dart';
import 'package:test/controller/product_controller.dart';
import 'package:test/repo/db_repo.dart';
import 'package:test/view/login/login.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});

  // Initializing the ProductController using GetX dependency injection.
  final controller = Get.put<ProductController>(ProductController());

  @override
  Widget build(BuildContext context) {
    // Function to check and add products to the database if not already present.
    Future<void> _checkAndAddProducts() async {
      final dbHelper = DatabaseRepo();

      // Fetch products from the database and store them in the controller.
      await controller.fetchProductsFromDb();

      // If the database is empty, add the default products from `productsInLocal`.
      if (controller.productFromDb.isEmpty) {
        for (var product in controller.productsInLocal) {
          await dbHelper
              .addProduct(product); // Add each product to the database.
        }

        // Fetch the updated product list from the database.
        await controller.fetchProductsFromDb();
      }

      // Navigate to the LoginScreen after the check is complete.
      Get.off(LoginScreen());
    }

    // Schedule the `_checkAndAddProducts` function to run after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 3));
      await _checkAndAddProducts();
    });

    // Return the UI for the splash screen.
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Store',
              style: TextStyle(
                  fontSize: 50, color: kblue, fontWeight: FontWeight.w700),
            ),
            Lottie.asset('assets/lottie/splash.json'),
          ],
        ),
      )),
    );
  }
}
