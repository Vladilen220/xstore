import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/icons/t_circular_icon.dart';
import 'package:xstore/common/widgets/layouts/grid_layout.dart';
import 'package:xstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:xstore/navigation_menu.dart';

import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationController>();

    return Scaffold(
        appBar: TAppBar(
          title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCircularIcon(icon: Iconsax.add, onPressed: () {
              controller.selectedIndex.value = 0; // Navigate to HomeScreen
            }),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                TGridLayout(itemCount: 6, itemBuilder: (_, index) => const TProductCardVertical()),
              ],
            ),
          ),
        )
    );
  }
}