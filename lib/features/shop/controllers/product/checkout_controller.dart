import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/utils/constants/enums.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/constants/sizes.dart';

import '../../../../common/widgets/texts/payment_title.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: TImages.payPal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context){

    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(title: 'Select Payment Method', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'Paypal', image: TImages.payPal)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: TImages.googlePay)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: TImages.applePay)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'VISA', image: TImages.visa)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'Master Card', image: TImages.masterCard)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'Paytm', image: TImages.paytm)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'PayStack', image: TImages.payStack)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                TPaymentTitle(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: TImages.creditCard)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                const SizedBox(height: TSizes.spaceBtwSections,)
              ],
            ),
          ),
        )
    );
  }
}