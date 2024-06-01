import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/auth/controller/user/user_controller.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';
import 'package:textspeech/interface/user/edit_profile.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/curved_edges.dart';
import 'package:textspeech/util/etc/responsive.dart';
import 'package:textspeech/util/shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      backgroundColor: const Color(0xFFfab800),
      appBar: isMobile(context)
          ? AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 250), () {
                      Get.offNamed('/home');
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kWhite,
                  )
                      .animate(delay: const Duration(milliseconds: 250))
                      .slideX(begin: -2, end: 0)),
              title: Text(
                'Back',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.normal, color: kWhite),
              ),
            )
          : AppBar(),
      body: isMobile(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                    clipper: TCustomCurvedEdges(),
                    child: Container(
                      color: Colors.blueAccent,
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                          widht: 70,
                                          height: 70,
                                          isNetworkImage:
                                              networkImage.isNotEmpty,
                                        );
                                })
                                    .animate(
                                        delay:
                                            const Duration(milliseconds: 250))
                                    .slideY(
                                        begin: 2,
                                        end: 0,
                                        duration:
                                            const Duration(milliseconds: 700)),
                                const SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      if (controller.profileLoading.value) {
                                        return const DShimmerEffect(
                                          width: 80,
                                          height: 15,
                                        );
                                      } else {
                                        return Text(
                                          controller.user.value.fullName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .apply(color: Colors.red),
                                        );
                                      }
                                    }),
                                    const SizedBox(height: 8.0),
                                    Obx(() {
                                      if (controller.profileLoading.value) {
                                        return const DShimmerEffect(
                                          width: 80,
                                          height: 15,
                                        );
                                      } else {
                                        return Text(
                                          controller.user.value.email,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .apply(color: Colors.red),
                                        );
                                      }
                                    }),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 30,
                                  color: kError,
                                ),
                                GestureDetector(
                                  onTap: () => AuthenticationRepository.instance
                                      .logOut(),
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: kWhite),
                                        borderRadius:
                                            BorderRadius.circular(2.0)),
                                    child: Center(
                                      child: Text(
                                        'LOGOUT',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(color: kWhite),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Get.toNamed('/edit-profile'),
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: kWhite),
                                        borderRadius:
                                            BorderRadius.circular(2.0)),
                                    child: Center(
                                      child: Text(
                                        'EDIT PROFILE',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(color: kWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Text(
                        'My Albums',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: kWhite,
                      ),
                      const SizedBox(height: 12.0),
                      Container(
                        height: 100,
                        width: 100,
                        color: kWhite,
                      ),
                      Text(
                        'nanti taro navbar (rate us, ContactUs, report bug)',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                )
              ],
            )
          : Container(
              width: Get.width,
              height: Get.height,
              color: Colors.red,
            ),
    );
  }
}
