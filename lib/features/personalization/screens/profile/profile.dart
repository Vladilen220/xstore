import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/images/t_circular_image.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/features/personalization/screens/profile/widgets/change_email.dart';
import 'package:xstore/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:xstore/features/personalization/screens/profile/widgets/change_phone_number.dart';
import 'package:xstore/features/personalization/screens/profile/widgets/change_username.dart';
import 'package:xstore/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/constants/sizes.dart';

import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(
          () => Scaffold(
        appBar: const TAppBar(showBackArrow: true, title: Text('Profile')),
        // -- Body
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children:[
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                      return controller.imageUploading.value
                          ? const TShimmerEffect(width: 80, height: 80, radius: 80,)
                          : TCircularImage(image: image,width: 80,height: 80, isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture'))
                      ],
                   ),
                 ),
                /// Details
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                /// Heading Profile Info
                const TSectionHeading(title: 'Profile Information', showActionButton: false,),
                const SizedBox(height: TSizes.spaceBtwItems),

                TProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to( () => const ChangeName())),
                TProfileMenu(title: 'Username', value: controller.user.value.username,onPressed: () => Get.to( () => const ChangeUsername())),

                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Heading Profile Info
                TProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy ,onPressed: () {}),
                TProfileMenu(title: 'E-mail', value: controller.user.value.email,onPressed: () => Get.to( () => const ChangeEmail())),
                TProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber,onPressed: () => Get.to( () => const ChangePhoneNumber())),
                //TProfileMenu(title: 'Gender', value: 'Male',onPressed: () {}),
                //TProfileMenu(title: 'Date of Birth', value: '10 Oct, 1994',onPressed: () {}),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                Center(
                  child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

