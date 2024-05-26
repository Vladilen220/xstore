import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/bindings/general_bindings.dart';
import 'package:xstore/utils/constants/colors.dart';
import 'package:xstore/utils/theme/theme.dart';

// void main() {
//   runApp(const App());
// }

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      //debugShowCheckedModeBanner: false,
      home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
      //home: const OnBoardingScreen(),
    );
  }
}