import 'package:flutter/material.dart';
import 'package:xstore/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:xstore/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:xstore/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:xstore/utils/constants/sizes.dart';

import '../../../../utils/helpers/helper_functions.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            ///  -- Product Image Slider
            TProductImageSlider(),

            /// -- Product Details
            Padding(
              padding: EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Rating &Share Button
                  TRatingAndShare(),
                  /// Price, Title, Stock & Brand
                  TProductMetaData()
                  /// Attributes
                  /// Checkout Button
                  /// Description
                  /// Reviews
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}




