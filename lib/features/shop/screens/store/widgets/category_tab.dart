import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:xstore/common/widgets/layouts/grid_layout.dart';
import 'package:xstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/features/shop/controllers/category_controller.dart';
import 'package:xstore/features/shop/models/product_model.dart';
import 'package:xstore/features/shop/screens/all_products/all_products.dart';
import 'package:xstore/features/shop/screens/store/widgets/category_brands.dart';

import '../../../../../common/widgets/brands/brands_show_case.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/category_model.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              CategoryBrands(category: category),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Products
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {

                    final response =
                    TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const TVerticalProductShimmer());
                    if (response != null) return response;

                    final products = snapshot.data!;

                    return Column(
                      children: [
                        TSectionHeading(
                          title: 'You might like',
                          onPressed: () => Get.to(
                            AllProducts(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) =>
                                TProductCardVertical(product: products[index]))
                      ],
                    );
                  }),

              // Obx(() {
              //   if(xcontroller.isLoading.value) return const TVerticalProductShimmer();
              //
              //   if(xcontroller.featuredProducts.isEmpty){
              //     return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
              //   }
              //   return TGridLayout(
              //       itemCount: xcontroller.featuredProducts.length,
              //       itemBuilder: (_, index) => TProductCardVertical(product: xcontroller.featuredProducts[index]));
              // })
            ],
          ),
        ),
      ],
    );
  }
}
