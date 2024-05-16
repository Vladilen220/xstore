import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:xstore/features/shop/screens/checkout/checkout.dart';
import 'package:xstore/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding:  EdgeInsets.all(TSizes.defaultSpace),
        /// items in Cart

        child: TCartItems(),
      ),

      /// Check out Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child: const Text('Checkout \$256.0'),),
      ),
    );
  }
}
