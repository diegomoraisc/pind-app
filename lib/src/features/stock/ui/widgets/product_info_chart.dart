import 'package:flutter/material.dart';

class ProductInfoChart extends StatefulWidget {
  final String productName;
  final double? productQuantity;

  const ProductInfoChart({
    Key? key,
    required this.productName,
    required this.productQuantity,
  }) : super(key: key);

  @override
  ProductInfoChartState createState() => ProductInfoChartState();
}

class ProductInfoChartState extends State<ProductInfoChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _toggleVisibility();
  }

  @override
  void didUpdateWidget(ProductInfoChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _toggleVisibility();
  }

  void _toggleVisibility() {
    if (widget.productName.isNotEmpty && widget.productQuantity! > 0.0) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isVisible =
        widget.productName.isNotEmpty && widget.productQuantity! > 0.0;

    BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 2.5,
          spreadRadius: .5,
          offset: const Offset(0, 1.5),
        ),
      ],
    );

    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(
          minHeight: isVisible ? 150 : 1,
          minWidth: isVisible ? 150 : 1,
        ),
        decoration: boxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.productName,
              style: theme.textTheme.titleLarge,
            ),
            Text(
              widget.productQuantity != null && widget.productQuantity! > 0.0
                  ? "${widget.productQuantity!.toStringAsFixed(0)} kg"
                  : "",
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
