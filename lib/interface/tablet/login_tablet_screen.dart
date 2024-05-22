import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../auth/controller/introduction_controller.dart';
import '../../auth/forget_pw.dart';
import '../../util/etc/app_colors.dart';

class LoginTabletScreen extends StatelessWidget {
  final IntroductionController controller;
  const LoginTabletScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.only(top: 200),
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                'assets/banner_animals.png',
              ))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 15),
                Text(
                  'Come on in and explore the world of fun learning with us! Please login before playing',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          Form(
              key: controller.loginFromKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 70),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required.';
                        }

                        final emailRegExp =
                            RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                        if (!emailRegExp.hasMatch(value)) {
                          return 'Invalid email address.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct),
                        labelText: 'E-Mail',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Remember me & forgot pw
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember Me
                        Row(
                          children: [
                            Obx(
                              () => SizedBox(
                                width: 30,
                                height: 30,
                                child: Checkbox(
                                  value: controller.rememberMe.value,
                                  onChanged: (value) => controller.rememberMe
                                      .value = !controller.rememberMe.value,
                                ),
                              ),
                            ),
                            Text(
                              'Remember Me',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),

                        // Forgot password
                        TextButton(
                            onPressed: () =>
                                Get.to(() => const ForgetPassword()),
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.apply(color: Colors.blueAccent.shade400),
                            ))
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.emailAndPasswordSignIn(),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueAccent)),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () => Get.toNamed('/signup'),
                          child: const Text('Create Account')),
                    ),
                  ],
                ),
              )),
          // Divider
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                  child: Divider(
                color: kGrey,
                thickness: .5,
                indent: 60,
                endIndent: 10,
              )),
              Text(
                'or sign in with',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: kGrey),
              ),
              const Flexible(
                  child: Divider(
                color: kGrey,
                thickness: .5,
                indent: 10,
                endIndent: 60,
              )),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kGrey),
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  onPressed: () => controller.googleSignIn(),
                  icon: const Image(
                      width: 40,
                      height: 40,
                      image: AssetImage('assets/images/google.png')),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kGrey),
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  onPressed: () {},
                  icon: const Image(
                      width: 40,
                      height: 40,
                      image: AssetImage('assets/images/fb.png')),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
