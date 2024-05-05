import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/user_controller.dart';
import 'package:textspeech/util/auth_controller.dart';
import 'package:textspeech/util/curved_edges.dart';
import 'package:textspeech/util/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      backgroundColor: const Color(0xFFfab800),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 250), () {
                Get.offNamed('/home');
              });
            },
            icon: const Icon(Icons.arrow_back_ios)
                .animate(delay: const Duration(milliseconds: 250))
                .slideX(begin: -2, end: 0)),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed('/edit-profile'),
              icon: const Icon(Iconsax.edit))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  color: const Color(0xFFfffffc),
                  child: Center(
                      child: Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                          color: Color.fromARGB(255, 176, 173, 168))),
                      image: DecorationImage(
                          image: AssetImage('assets/images/cat.png'),
                          fit: BoxFit.fill),
                      shape: BoxShape.circle,
                    ),
                  ).animate(delay: const Duration(milliseconds: 250)).slideY(
                          begin: 2,
                          end: 0,
                          duration: const Duration(milliseconds: 700))),
                ),
              ),
            ),
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
            IconButton(
                onPressed: () => AuthenticationRepository.instance.logOut(),
                icon: const Icon(Iconsax.logout))
          ],
        ),
      ),
    );
  }
}
