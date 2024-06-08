import 'package:flutter/cupertino.dart';
import 'package:xstore/common/widgets/brands/brands_show_case.dart';
import 'package:xstore/features/shop/models/category_model.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/constants/sizes.dart';
import 'package:xstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../controllers/brand_controller.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});
  
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        const loader = Column(
          children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
            TBoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
          ],
        );

        final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if(widget != null) return widget;

        final brands = snapshot.data!;

        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
               return FutureBuilder(
                 future: controller.getBrandProducts(limit: 3,brandId: brand.id),
                 builder: (context, snapshot) {

                   final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                   if(widget != null) return widget;

                   final products = snapshot.data!;
                   return TBrandShowcase(brand: brand ,images: products.map((e) => e.thumbnail).toList());
                 }
               );
              },
            );
        }
    );
  }
}
