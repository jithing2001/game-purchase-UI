import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/product_controller.dart';
import 'package:test/view/checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: GetBuilder<ProductController>(
        builder: (controller) => Column(
          children: [
            Expanded(
                child: controller.cart.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.cart.length,
                        itemBuilder: (context, index) {
                          final product = controller.cart[index];
                          return ListTile(
                            leading: Image.asset(product.imageUrl,
                                width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(product.name),
                            subtitle: Text('₹${product.price}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () =>
                                  controller.removeFromCart(product),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('Your Cart is empty'),
                      )),
            if (controller.cart.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Total: ₹${controller.totalCost}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => Get.to(CheckoutScreen(
                        products: controller.cart,
                      )),
                      child: const Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
