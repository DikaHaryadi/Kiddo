import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';

import '../../util/etc/app_colors.dart';

class RegisterMobileScreen extends StatelessWidget {
  final SignupController controller;
  const RegisterMobileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 10),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        const SizedBox(height: 10.0),
        Text("Let's create your account",
            style: Theme.of(context).textTheme.displayLarge),
        Form(
          key: controller.signupFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        controller: controller.firstName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: TextFormField(
                        controller: controller.lastName,
                        expands: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last Name is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: 'Last Name',
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.userName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user_edit),
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
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

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long.';
                      }
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Password must contain at least one number';
                      }
                      if (!value.contains(RegExp(r'[!@#$%^&*(),.?"{}|<>]'))) {
                        return 'Password must contain at least one special character';
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
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(
                          () => Checkbox(
                            value: controller.privacyPolicy.value,
                            onChanged: (value) => controller.privacyPolicy
                                .value = !controller.privacyPolicy.value,
                          ),
                        )),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'i aggree to ',
                            style: GoogleFonts.aBeeZee(
                                color: kGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kDark,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                        TextSpan(
                            text: ' and ',
                            style: GoogleFonts.aBeeZee(
                                color: kGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        TextSpan(
                            text: 'Terms of use',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kDark,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline))
                      ])),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.signup(),
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent)),
                      child: const Text(
                        'Create Account',
                      )),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        child: Divider(
                      color: kGrey,
                      thickness: .5,
                      indent: 60,
                      endIndent: 5,
                    )),
                    Text(
                      'or sign up with',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: kGrey),
                    ),
                    const Flexible(
                        child: Divider(
                      color: kGrey,
                      thickness: .5,
                      indent: 5,
                      endIndent: 60,
                    )),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kGrey),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                            width: 24,
                            height: 24,
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
                            width: 24,
                            height: 24,
                            image: AssetImage('assets/images/fb.png')),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
