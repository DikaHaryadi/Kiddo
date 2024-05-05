import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/user_controller.dart';
import 'package:textspeech/util/widgets/change_name.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder()),
                          child: Image.asset(
                            'assets/images/cat.png',
                            width: 80,
                            fit: BoxFit.fitHeight,
                          )),
                      const SizedBox(height: 8.0),
                      TextButton(
                          onPressed: () {},
                          child: const AutoSizeText('Change Profile Picture',
                              minFontSize: 12, maxFontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  'Profile Information',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _profileMenu('Name', controller.user.value.fullName,
                    () => Get.to(() => const ChangeName())),
                _profileMenu('Username', controller.user.value.username, () {}),
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  'Personal Information',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _profileMenu(
                  'User ID',
                  controller.user.value.id,
                  () {},
                  Iconsax.copy,
                ),
                _profileMenu('E-mail', controller.user.value.email, () {}),
                _profileMenu('Gender', 'Male', () {}),
                _profileMenu('Date of Birth', '17 Augst, 2001', () {}),
                const Divider(),
                const SizedBox(height: 16.0),
                Center(
                  child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopUp(),
                    child: const AutoSizeText('Clear Account'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _profileMenu(String title, value, VoidCallback ontap, [IconData? iconData]) {
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            title,
            style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
            onPressed: ontap, icon: Icon(iconData ?? Iconsax.arrow_right))
      ],
    );
  }
}
