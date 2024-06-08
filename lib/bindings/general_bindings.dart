import 'package:get/get.dart';
import 'package:xstore/features/personalization/controllers/address_controller.dart';
import 'package:xstore/features/shop/controllers/product/cart_controller.dart';
import 'package:xstore/features/shop/controllers/product/checkout_controller.dart';
import 'package:xstore/features/shop/controllers/product/variation_controller.dart';
import 'package:xstore/utils/helpers/theme_controller.dart';
import 'package:xstore/utils/http/network_manager.dart';

class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(ThemeController());
    //Get.put(CartController());
  }
}