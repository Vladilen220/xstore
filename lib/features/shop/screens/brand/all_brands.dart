import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/brands/brand_card.dart';
import 'package:xstore/common/widgets/layouts/grid_layout.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/features/shop/screens/brand/brand_products.dart';
import 'package:xstore/utils/constants/sizes.dart';

import '../../controllers/brand_controller.dart';
import '../../models/brand_model.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('Brands'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Heading
                const TSectionHeading(title: 'Brands',showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// -- Brands
                TGridLayout(itemCount: brandController.featuredBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) {
                    final brand = brandController.featuredBrands[index];
                    return TBrandCard(showBorder: true,  onTap: () => Get.to(() => BrandProducts(brand: brand)), brand: brand);
                    return TBrandCard(showBorder: true, onTap: () => Get.to(() => BrandProducts(brand: brand)), brand: BrandModel.empty(),)
                    ;
                  }),
              ],
            )),
      ),
    );
  }
}
