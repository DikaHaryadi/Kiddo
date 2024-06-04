import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/user/user_controller.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/shimmer/shimmer.dart';

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
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : 'assets/images/cat.png';
                        return controller.imageUploading.value
                            ? const DShimmerEffect(
                                width: 80, height: 80, radius: 80)
                            : CircularImage(
                                image: image,
                                widht: 160,
                                height: 160,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      }),
                      const SizedBox(height: 8.0),
                      TextButton(
                          onPressed: () =>
                              controller.uploadUserProfilePicture(),
                          child: const AutoSizeText(
                            'Change Profile Picture',
                          )),
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
                    () => Get.toNamed('/edit-name')),
                _profileMenu('Username', controller.user.value.username,
                    () => Get.toNamed('/edit-username')),
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
                const Divider(),
                const SizedBox(height: 16.0),
                Center(
                  child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopUp(),
                    child: AutoSizeText(
                      'Clear Account',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.apply(color: kError),
                    ),
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

class CircularImage extends StatelessWidget {
  const CircularImage(
      {super.key,
      this.fit,
      required this.image,
      this.isNetworkImage = true,
      this.overlayColor,
      this.widht = 56,
      this.height = 56,
      this.padding = 8.0,
      this.onTap});

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final void Function()? onTap;
  final double widht, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widht,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? InkWell(
                  onTap: onTap,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: fit,
                    color: overlayColor,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const DShimmerEffect(
                      width: 55,
                      height: 55,
                      radius: 55,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              : InkWell(
                  onTap: onTap,
                  child: Image(
                    image: AssetImage(image),
                    fit: fit,
                    color: overlayColor,
                  ),
                ),
        ),
      ),
    );
  }
}
