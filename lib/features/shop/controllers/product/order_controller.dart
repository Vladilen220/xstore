import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xstore/common/widgets/success_screen/success_screen.dart';
import 'package:xstore/data/repositories/authenitcation/authentication_repository.dart';
import 'package:xstore/features/personalization/controllers/address_controller.dart';
import 'package:xstore/features/shop/controllers/product/cart_controller.dart';
import 'package:xstore/features/shop/controllers/product/checkout_controller.dart';
import 'package:xstore/navigation_menu.dart';
import 'package:xstore/utils/constants/enums.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/popups/full_screen_loader.dart';
import 'package:xstore/utils/popups/loaders.dart';

import '../../../../data/repositories/order/order_repository.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try{
      TFullScreenLoader.openLoadingDialog('Processing your order', TImages.pencildrawing);

      final userId = AuthenticationRepository.instance.authUser?.uid;
      if(userId!.isEmpty) return ;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );
      await orderRepository.saveOrder(order, userId);
      await orderRepository.saveCollectionOrder(order, userId);
      cartController.clearCart();
      
      Get.off( () => SuccessScreen(
        image: TImages.successfullyRegisterAnimation,
        title: 'Payment Success!',
        subTitle: 'Your item will be shipped soon! Your Order ID Is: ${order.id}',
        onPressed: () => Get.offAll(() => const NavigationMenu(initialIndex: 0,)),
      ));
  } catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
  }
  }

}