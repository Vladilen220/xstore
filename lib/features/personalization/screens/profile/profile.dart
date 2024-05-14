import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/images/t_circular_image.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:xstore/utils/constants/image_strings.dart';
import 'package:xstore/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const TCircularImage(image: TImages.user,width: 80,height: 80),
                  TextButton(onPressed: (){}, child: const Text('Change Profile Picture'))
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

              TProfileMenu(title: 'Name', value: 'Youssef', onPressed: () {}),
              TProfileMenu(title: 'Username', value: 'Joe',onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Profile Info
              TProfileMenu(title: 'User ID', value: '45689', icon: Iconsax.copy ,onPressed: () {}),
              TProfileMenu(title: 'E-mail', value: 'support@xstore.com',onPressed: () {}),
              TProfileMenu(title: 'Phone Number', value: '+20 1111111111',onPressed: () {}),
              TProfileMenu(title: 'Gender', value: 'Male',onPressed: () {}),
              TProfileMenu(title: 'Date of Birth', value: '10 Oct, 1994',onPressed: () {}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: (){},
                  child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

