import 'package:flutter/material.dart';
import 'package:test/model/product_model.dart';

class ProductCoverImage extends StatelessWidget {
  const ProductCoverImage({
    required this.product,
    super.key,
    this.height,
  });

  final Product product;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: AspectRatio(
            aspectRatio: .56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 40,
                    offset: Offset(-20, 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
