import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xstore/app.dart';
import 'package:xstore/utils/helpers/theme_controller.dart';

import 'data/repositories/authenitcation/authentication_repository.dart';
import 'features/shop/controllers/product/cart_controller.dart';
import 'features/shop/controllers/product/variation_controller.dart';
import 'firebase_options.dart';
import 'navigation_menu.dart';
//import 'package:xstore/utils/theme/theme.dart';

Future<void> main() async {
  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// -- Get Local Storage
  await GetStorage.init();

  /// -- Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
 final ThemeController themeController = Get.put(ThemeController());


  Get.put(NavigationController());
  runApp(const App());
}

