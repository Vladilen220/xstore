import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/appbar/tabbar.dart';
import 'package:xstore/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:xstore/common/widgets/layouts/grid_layout.dart';
import 'package:xstore/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/features/shop/screens/brand/all_brands.dart';
import 'package:xstore/features/shop/screens/store/widgets/category_tab.dart';
import 'package:xstore/utils/constants/sizes.dart';
import 'package:xstore/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../utils/constants/colors.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        /// App Bar
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(onPressed: (){}, )
          ],
        ),
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
              expandedHeight: 440,

              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children:  [
                    /// -- Search bar
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSearchContainer(text: 'Search in the store', showBorder: true, showBackground: false, padding: EdgeInsets.zero),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// -- Featured Brands
                    TSectionHeading(title: 'Featured Brands', onPressed: () => Get.to(() => const AllBrandsScreen())),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                    /// -- Brands Grid
                    TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_,index){
                      return   const TBrandCard(showBorder: false);
                    })
                  ],
                ),
              ),
              /// Tabs
              bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Electronics')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Cosmetics')),
                 ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              TCategoryTab(),TCategoryTab(),TCategoryTab(),TCategoryTab(),TCategoryTab()],

            ),
          ),
        ),
      );
    }
  }






