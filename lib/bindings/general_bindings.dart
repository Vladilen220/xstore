import 'package:get/get.dart';
import 'package:xstore/utils/http/network_manager.dart';

class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}