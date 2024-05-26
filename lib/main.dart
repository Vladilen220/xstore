import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xstore/app.dart';

import 'data/repositories/authenitcation/authentication_repository.dart';
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

  Get.put(NavigationController());
  runApp(const App());
}

