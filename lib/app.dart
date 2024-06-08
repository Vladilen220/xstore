import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xstore/bindings/general_bindings.dart';
import 'package:xstore/routes/app_routes.dart';
import 'package:xstore/utils/constants/colors.dart';
import 'package:xstore/utils/helpers/theme_controller.dart';
import 'package:xstore/utils/theme/theme.dart';

// void main() {
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({super.key});
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  GetMaterialApp(
//       themeMode: ThemeMode.system,
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       initialBinding: GeneralBindings(),
//       debugShowCheckedModeBanner: false,
//       getPages: AppRoutes.pages,
//       home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
//       //home: const OnBoardingScreen(),
//     );
//   }
// }

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return GetMaterialApp(
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}