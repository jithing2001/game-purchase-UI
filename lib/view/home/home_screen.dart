import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/const.dart';
import 'package:test/controller/product_controller.dart';
import 'package:test/model/product_model.dart';
import 'package:test/view/cart/cart_screen.dart';
import 'package:test/view/detail/product_detail.dart';
import 'package:test/view/home/widgets/product_cover_widget.dart';
import 'package:test/view/widgets/draggable_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final bool enableEntryAnimation = false;

  final ProductController controller = Get.find<ProductController>();

  late List<Product> products;
  late int currentIndex;

  @override
  void initState() {
    products = controller.productFromDb;
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductController>(
        builder: (controller) {
          return Column(
            children: [
              kheight40,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.to(CartScreen());
                    },
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PURCHASE YOUR GAMES',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ],
              ),
              kheight20,
              Expanded(
                child: InfiniteDragableSlider(
                  iteamCount: products.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(ProductDetailsScreen(product: products[index]));
                      },
                      child: ProductCoverImage(product: products[index])),
                ),
              ),
              kheight10,
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              ProductDetailsScreen(product: products[index]));
                        },
                        child: SizedBox(
                          width: 100,
                          child: Image.asset(
                            products[index].imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              kheight20
            ],
          );
        },
      ),
    );
  }
}
