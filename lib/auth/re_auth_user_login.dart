import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/user/user_controller.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class ReAuthForm extends StatelessWidget {
  const ReAuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
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
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.direct),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1, color: kGrey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1, color: kGrey)),
                      labelText: 'E-Mail',
                      labelStyle: GoogleFonts.aBeeZee(
                          color: kGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => TextFormField(
                    controller: controller.verifyPassword,
                    obscureText: controller.hidePassword.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kata Sandi Tidak Boleh Kosong';
                      }

                      if (value.length < 6) {
                        return 'Kata sandi harus terdiri dari minimal 6 karakter';
                      }
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Kata sandi harus mengandung setidaknya satu huruf besar';
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
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(width: 1, color: kGrey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(width: 1, color: kGrey)),
                        suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: Icon(controller.hidePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye)),
                        labelStyle: GoogleFonts.aBeeZee(
                            color: kGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailAndPasswordUser(),
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent)),
                      child: Text(
                        'Buat Akun',
                        style: GoogleFonts.archivoBlack(color: Colors.white),
                      )),
                ),
              ],
            )),
      )),
    );
  }
}
