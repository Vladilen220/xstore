import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/images/t_rounded_image.dart';
import 'package:xstore/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/features/shop/controllers/category_controller.dart';
import 'package:xstore/features/shop/models/category_model.dart';
import 'package:xstore/features/shop/screens/all_products/all_products.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/constants/sizes.dart';
import 'package:xstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/shimmers/horizontal_product_shimmer.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Banner
              // TRoundedImage(width: double.infinity, imageUrl: category.image, applyImageRadius: true, isNetworkImage: true,),
              // const SizedBox(height: TSizes.spaceBtwSections),

              /// Sub-Categories
              FutureBuilder(
                future: controller.getSubCategory(category.id),
                builder: (context, snapshot) {

                  const loader = THorizontalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null ) return widget;

                  final subCategories = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_,index) {

                        final subCategory = subCategories[index];
                        return FutureBuilder(
                          future: controller.getCategoryProducts(categoryId: subCategory.id),
                          builder: (context, snapshot) {

                            final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                            if(widget != null ) return widget;

                            final products = snapshot.data!;

                            return Column(
                              children: [
                                /// Heading
                                TSectionHeading(title: subCategory.name,
                                  onPressed: () => Get.to(
                                      () => AllProducts(
                                          title: subCategory.name,
                                          futureMethod: controller.getCategoryProducts(categoryId: subCategory.id, limit: -1),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems / 2),

                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
                                      itemBuilder: (context, index) => TProductCardHorizontal(product: products[index]),
                                  ),
                                ),

                                const SizedBox(height: TSizes.spaceBtwSections),

                              ],
                            );
                          }
                        );
                      },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
