import 'package:flutter/material.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/brands/brand_card.dart';
import 'package:xstore/common/widgets/products/sortable/sortable_products.dart';
import 'package:xstore/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:xstore/features/shop/controllers/brand_controller.dart';
import 'package:xstore/features/shop/models/brand_model.dart';
import 'package:xstore/utils/constants/sizes.dart';
import 'package:xstore/utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller =BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name),showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              TBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),

              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot){

                    const loader = TVerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                    if(widget != null) return widget;

                    final brandProducts = snapshot.data!;
                    return TSortableProducts(products: brandProducts);
                  }
              )
            ],
          ),
        ),
      )
    );
  }
}
