import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xstore/common/widgets/appbar/appbar.dart';
import 'package:xstore/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:xstore/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:xstore/common/widgets/texts/section_heading.dart';
import 'package:xstore/features/personalization/screens/address/address.dart';
import 'package:xstore/features/shop/screens/order/order.dart';
import 'package:xstore/utils/constants/sizes.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../data/repositories/authenitcation/authentication_repository.dart';
import '../../../../data/repositories/categories/cateogry_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/dummy_data.dart';
import '../../../../utils/helpers/theme_controller.dart';
import '../../../shop/screens/cart/cart.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryRepository categoryRepository = CategoryRepository();
    final ProductRepository productRepository = ProductRepository();
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: TColors.white))),

                  ///User Profile Card
                   TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// -- Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set Shopping delivery address', onTap: ()=> Get.to(() => const UserAddressScreen())),
                  TSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add, remove products and move to checkout', onTap: ()=> Get.to(() => const CartScreen())),
                  TSettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'In-progress and Completed Orders', onTap: ()=> Get.to(() => const OrderScreen())),
                  TSettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account', onTap: (){}),
                  TSettingsMenuTile(icon: Iconsax.receipt_discount, title: 'My Coupons', subTitle: 'List of all discounted coupons', onTap: (){}),
                  TSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message', onTap: (){}),
                  TSettingsMenuTile(icon: Icons.privacy_tip_outlined, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts', onTap: (){}),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  //SettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase', onTap: (){categoryRepository.uploadDummyData(TDummyData.csategories);} ),
                  TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase', onTap: (){productRepository.uploadDummyData(TDummyData.products);} ),
                  TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Geolocation',
                      subTitle: 'Set recommendation based on location',
                      trailing: Switch(value: true, onChanged: (value){},),
                      ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value){},),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value){},),
                  ),
                  /// -- Dark Mode Toggle
                  Obx(() => TSettingsMenuTile(
                    icon: Iconsax.moon,
                    title: 'Dark Mode',
                    subTitle: 'Toggle Dark/Light mode',
                    trailing: Switch(
                      value: themeController.isDarkMode,
                      onChanged: (value) => themeController.toggleTheme(),
                    ),
                  )),
                  TSettingsMenuTile(
                    icon: Iconsax.message,
                    title: 'Chatbot Support',
                    subTitle: 'Get help from our chatbot',
                    onTap: () => Get.to(() => const ChatbotScreen()),
                  ),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => AuthenticationRepository.instance.logout(), child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ChatbotScreen());
        },
        backgroundColor: TColors.primary,
        child: const Icon(Icons.chat),
      ),
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  final String apiUrl =
      'https://api-inference.huggingface.co/models/Doter/faq_model';
  final String apiToken =
      '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'; // Replace with your actual API token

  Future<void> _sendMessage(String message) async {
    try {
      final Map<String, dynamic> requestData = {
        "inputs": {
          "question": message,
          "context":
          "Hi! I'm Happy to help :) Of course ask your question! You're welcome. 2-3 business days to arrive. To recover your password after forgetting it 'just go to the login page and click on 'Forgot Password' then follow the instructions'. To create/register a new account 'logout and click Register then enter your credintials'."
        }
      };
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiToken',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final generatedText =
        responseData['answer']; // Assuming the API returns an 'answer' key
        setState(() {
          _messages.add("User: $message");
          _messages.add("Bot: $generatedText");
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Failed to fetch response: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message),
                  tileColor: index % 2 == 0 ? Colors.grey[200] : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final value = _controller.text;
                    if (value.isNotEmpty) {
                      await _sendMessage(value);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

