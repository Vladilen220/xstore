import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/icons/t_circular_icon.dart';
import 'package:xstore/common/widgets/layouts/grid_layout.dart';
import 'package:xstore/common/widgets/loaders/animation_loader.dart';
import 'package:xstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:xstore/features/shop/controllers/product/favourites_controller.dart';
import 'package:xstore/features/shop/models/product_model.dart';
import 'package:xstore/features/shop/screens/store/store.dart';
import 'package:xstore/navigation_menu.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationController>();
    //final xcontroller = Get.put(ProductController());
    final xcontroller = FavouritesController.instance;

    return Obx(
      () => Scaffold(
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


              child: FutureBuilder(
                future: xcontroller.favoriteProducts(),
                builder: (context, snapshot) {

                  final emptyWidget = TAnimationLoaderWidget(
                    text: 'Whoops! Wishlist is Empty..',
                    animation: TImages.pencildrawing,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () {
                      controller.selectedIndex.value = 0; // Navigate to HomeScreen
                    },
                  );

                  const loader = TVerticalProductShimmer(itemCount: 6);
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader, nothingFound: emptyWidget);
                  if(widget !=null) return widget;

                  final products = snapshot.data!;
                  return TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_,index) => TProductCardVertical(product: products[index]),
                  );
                }
              ),
             // child: Column(
                // children: [ Obx(() {
                //   if(xcontroller.isLoading.value) return const TVerticalProductShimmer();
                //
                //   if(xcontroller.featuredProducts.isEmpty){
                //     return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                //   }
                //   return TGridLayout(
                //       itemCount: xcontroller.featuredProducts.length,
                //       itemBuilder: (_, index) => TProductCardVertical(product: xcontroller.featuredProducts[index]));
                // })
                //],
             // ),
            ),
          )
      ),
    );
  }
}