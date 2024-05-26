import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstore/data/repositories/authenitcation/authentication_repository.dart';
import 'package:xstore/features/authentication/screens/signup/verify_email.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/popups/loaders.dart';
import 'package:xstore/utils/popups/full_screen_loader.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/http/network_manager.dart';
import '../../models/user_model.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();


  /// -- SIGNUP
  void signup() async{
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);
      /// Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if(!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Privacy Policy Check
      if(!privacyPolicy.value){
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.'
        );
      }
      /// Register user in the FireBase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      /// Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName:firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      /// Remove loader

      /// Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');
      /// Move to Verify Email Screen
      Get.to( () => VerifyEmailScreen(email: email.text.trim()));
      } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      /// show some Generic Error to the user
      ///
    }
  }
}