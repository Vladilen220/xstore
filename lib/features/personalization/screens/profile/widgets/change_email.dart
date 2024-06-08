import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/update_email_controller.dart';
import '../../../controllers/update_name_controller.dart';
import '../../../controllers/update_phone_number_controller.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateEmailController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Email', style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Use personal phone number.',
              style: Theme.of(context).textTheme.labelMedium,
            ), // Text
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Text field and Button
            Form(
              key: controller.updateEmailFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    validator: (value) => TValidator.validateEmptyText('Email', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Icons.email)),
                  ), // TextFormField
                ],
              ),
            ), // Column, Form
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateEmail(), child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}