import 'package:flutter/material.dart';
import 'package:test/const.dart';
import 'package:test/model/product_model.dart';

class ExpandedContentWidget extends StatelessWidget {
  final Product product;

  const ExpandedContentWidget({
    required this.product,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            kheight10,
            Text(
              product.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              "₹${product.price}",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: kgreen),
            ),
            Text(
              product.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
}
