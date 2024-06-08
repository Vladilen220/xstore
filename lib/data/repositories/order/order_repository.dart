import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xstore/data/repositories/authenitcation/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if(userId!.isEmpty) throw 'Unable to find user Information. Try again in few minutes';
      
      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e){
      print('Error fetching orders: $e');
      throw 'Something went wrong while fetching order Information. try again later';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    } catch (e) {
      print('Error saving order: $e');
      throw 'Something went wrong while saving order Information. try again later';
    }
  }
  Future<void> saveCollectionOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('Orders').add(order.toJson());
    } catch (e) {
      print('Error saving order: $e');
      throw 'Something went wrong while saving order Information. try again later';
    }
  }
}