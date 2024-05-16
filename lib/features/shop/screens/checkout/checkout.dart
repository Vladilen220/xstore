import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:xstore/common/widgets/success_screen/success_screen.dart';
import 'package:xstore/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:xstore/features/shop/screens/checkout/widgets/billind_address_section.dart';
import 'package:xstore/features/shop/screens/checkout/widgets/billind_amount_section.dart';
import 'package:xstore/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:xstore/navigation_menu.dart';
import 'package:xstore/utils/constants/colors.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/constants/sizes.dart';
import 'package:xstore/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Items in cart
              const SizedBox(height: 250,child: TCartItems(showAddRemoveButtons: false)),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// -- Coupon TextField
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// -- Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    SizedBox(height: TSizes.spaceBtwItems),
                    TBillingPaymentSection(),

                    /// Address
                    TBillingAddressSection(),
                  ],
                ),
              )

            ],
          ),
        ),
      ),

      /// Check out Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(
                () =>  SuccessScreen(
              image: TImages.successfulPaymentIcon,
              title: 'Payment Success!',
              subTitle: 'Your item will be shipped soon!',
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            ),
          ),
          child: const Text('Checkout \$256.0'),),
      ),
    );
  }
}

