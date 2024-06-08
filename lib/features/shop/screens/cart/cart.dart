import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/common/widgets/loaders/animation_loader.dart';
import 'package:xstore/features/shop/controllers/product/cart_controller.dart';
import 'package:xstore/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:xstore/features/shop/screens/checkout/checkout.dart';
import 'package:xstore/navigation_menu.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(
            () {
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! Cart is EMPTY',
            animation: TImages.cartAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu(initialIndex: 0)),
          );

          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItems(),
            );
          }
        },
      ),

      /// Check out Button
      bottomNavigationBar: Obx(
            () => controller.cartItems.isEmpty
            ? const SizedBox()
            : Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Text('Checkout \$${controller.totalCartPrice.value}'),
          ),
        ),
      ),
    );
  }
}
