import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xstore/features/shop/controllers/product/all_products_controller.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../../shimmers/vertical_product_shimmer.dart';
import '../products_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    //final xcontroller = Get.put(ProductController());
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        /// Products
        // Obx(() {
        //   if(xcontroller.isLoading.value) return const TVerticalProductShimmer();
        //
        //   if(xcontroller.featuredProducts.isEmpty){
        //     return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
        //   }
        //   return TGridLayout(itemCount: xcontroller.featuredProducts.length, itemBuilder: (_, index) => TProductCardVertical(product: xcontroller.featuredProducts[index]));
        // })
        Obx(() => TGridLayout(itemCount: controller.products.length, itemBuilder: (_,index) => TProductCardVertical(product: controller.products[index])))
      ],
    );
  }
}