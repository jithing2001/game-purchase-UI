import 'package:flutter/material.dart';
import 'package:test/model/product_model.dart';

class ImageWidget extends StatelessWidget {
  final Product product;

  const ImageWidget({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      /// space from white container
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.8,
      width: size.width * 0.8,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            buildImage(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() => SizedBox.expand(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Image.asset(
            product.imageUrl,
            fit: BoxFit.fill, // Ensure the image covers the available space
            width: double.infinity, // Fill the width of the parent container
            height: double.infinity,
          ),
        ),
      );
}
