import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/introduction_controller.dart';
import 'package:textspeech/util/app_colors.dart';
import 'package:textspeech/util/responsive.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IntroductionController>();
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: isMobile(context)
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 24, top: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/Logo_color1.png',
                          width: 150,
                        ),
                        const SizedBox(height: 12),
                        AutoSizeText(
                          'Welcome back',
                          minFontSize: 33,
                          maxFontSize: 40,
                          style: GoogleFonts.archivoBlack(),
                        ),
                        const SizedBox(height: 15),
                        AutoSizeText(
                            'Come on in and explore the world of fun learning with us! Please login before playing on the homepage',
                            style: GoogleFonts.aBeeZee(
                                color: kDark, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Form(
                        key: controller.loginFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required.';
                                  }

                                  final emailRegExp = RegExp(
                                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                                  if (!emailRegExp.hasMatch(value)) {
                                    return 'Invalid email address.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Iconsax.direct),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            width: 1, color: kGrey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            width: 1, color: kGrey)),
                                    labelText: 'E-Mail',
                                    labelStyle: GoogleFonts.aBeeZee(
                                        color: kGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
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
                                      prefixIcon:
                                          const Icon(Iconsax.password_check),
                                      labelText: 'Password',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              width: 1, color: kGrey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              width: 1, color: kGrey)),
                                      suffixIcon: IconButton(
                                          onPressed: () => controller
                                                  .hidePassword.value =
                                              !controller.hidePassword.value,
                                          icon: Icon(
                                              controller.hidePassword.value
                                                  ? Iconsax.eye_slash
                                                  : Iconsax.eye)),
                                      labelStyle: GoogleFonts.aBeeZee(
                                          color: kGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Remember me & forgot pw
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Remember Me
                                  Row(
                                    children: [
                                      Obx(
                                        () => SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Checkbox(
                                            value: controller.rememberMe.value,
                                            onChanged: (value) => controller
                                                    .rememberMe.value =
                                                !controller.rememberMe.value,
                                          ),
                                        ),
                                      ),
                                      AutoSizeText(
                                        'Remember Me',
                                        style: GoogleFonts.aBeeZee(
                                            color: kGrey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),

                                  // Forgot password
                                  TextButton(
                                      onPressed: () =>
                                          Get.toNamed('/forgot-password'),
                                      child: const AutoSizeText(
                                          'Forgot Password?'))
                                ],
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controller.emailAndPasswordSignIn(),
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.blueAccent)),
                                    child: const AutoSizeText(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () => Get.toNamed('/signup'),
                                    child:
                                        const AutoSizeText('Create Account')),
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
                          endIndent: 5,
                        )),
                        AutoSizeText(
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
                          indent: 5,
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
                ))
            : Container(
                width: double.infinity,
                height: 100,
                color: Colors.red,
              ),
      ),
    ));
  }
}
