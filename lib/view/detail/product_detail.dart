import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/const.dart';
import 'package:test/controller/product_controller.dart';
import 'package:test/model/product_model.dart';
import 'package:test/view/checkout/checkout_screen.dart';
import 'package:test/view/detail/widgets/detail_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: ProductWidget(product: product)),
            Text('Hold & Swipe Up!'),
            kheight10,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      product.isInCart
                          ? controller.removeFromCart(product)
                          : controller.addToCart(product);
                      Get.snackbar(
                        product.isInCart ? 'Added to Cart' : 'Remove from Cart',
                        '${product.name} has been added to your cart.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: GetBuilder<ProductController>(builder: (controller) {
                      return Text(product.isInCart
                          ? 'Remove from Cart'
                          : 'Add to Cart');
                    }),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Buy Now',
                        middleText:
                            'Proceeding to checkout for ${product.name}.',
                        textConfirm: 'Continue',
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          Get.off(CheckoutScreen(
                            products: [product],
                          ));
                        },
                        textCancel: 'Cancel',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Buy Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
