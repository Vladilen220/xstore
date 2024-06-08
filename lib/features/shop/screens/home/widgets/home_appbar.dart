import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/features/personalization/controllers/user_controller.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/product/cart_controller.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final cartController = Get.put(CartController());
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
          Obx( (){
            if(controller.profileLoading.value) {
                // Display a shimmer loader while user profile is loading
                return const TShimmerEffect(width: 80, height: 15);
              } else {
              return Text(controller.user.value.fullName,style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.grey));
            }
          }),
        ],
      ),
      actions: [
        Obx(
        () {
      return cartController.isLoading.value
          ? CircularProgressIndicator() // Show a loader if isLoading is true
          : TCartCounterIcon(iconColor: TColors.white, counterBgColor: TColors.black, counterTextColor: TColors.white);
    })
       // Obx( () => TCartCounterIcon(iconColor: TColors.white, counterBgColor: TColors.black, counterTextColor: TColors.white, cartNo: cartController.noOfCarItems.toString(),)
        //),
      ],
    );
  }
}