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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Selamat datang kembali',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Ayo masuk dan jelajahi dunia belajar yang menyenangkan bersama kami! Silakan login sebelum bermain',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            Form(
                key: controller.loginFromKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Tidak Boleh Kosong';
                          }

                          final emailRegExp =
                              RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                          if (!emailRegExp.hasMatch(value)) {
                            return 'Alamat email tidak valid';
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
                              return 'Kata Sandi Tidak Boleh Kosong';
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
                      // Ingat Saya & forgot pw
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Ingat Saya
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
                                'Ingat Saya',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ),

                          // Forgot password
                          TextButton(
                              onPressed: () =>
                                  Get.to(() => const ForgetPassword()),
                              child: Text(
                                'Lupa Kata Sandi?',
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
                            onPressed: () =>
                                controller.emailAndPasswordSignIn(),
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.blueAccent)),
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
                            child: const Text('Buat Akun')),
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
                  'atau masuk dengan',
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
          ],
        ),
      ),
    );
  }
}
