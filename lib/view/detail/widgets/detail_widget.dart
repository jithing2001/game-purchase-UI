import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test/model/product_model.dart';
import 'package:test/view/detail/widgets/expanded_content_widget.dart';
import 'package:test/view/detail/widgets/image.widget.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({required this.product});

  @override
  _ProductWidgetState createState() {
    return _ProductWidgetState();
  }
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  bottom: isExpanded ? 10 : 40,
                  width: isExpanded ? size.width * 0.78 : size.width * 0.7,
                  height: isExpanded ? size.height * 0.7 : size.height * 0.6,
                  child: ExpandedContentWidget(product: widget.product),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  bottom: isExpanded ? size.height * 0.18 : size.height * 0.05,
                  child: GestureDetector(
                    onPanUpdate: onPanUpdate,
                    onTap: () {},
                    child: ImageWidget(product: widget.product),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
