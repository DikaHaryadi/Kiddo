import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/user/update_name_controller.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 16.0),
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama depan harus di isi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.user),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(width: 1, color: kGrey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(width: 1, color: kGrey)),
                          labelText: 'Nama depan',
                          labelStyle: GoogleFonts.aBeeZee(
                              color: kGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama belakang harus di isi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.user),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(width: 1, color: kGrey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(width: 1, color: kGrey)),
                          labelText: 'Nama belakang',
                          labelStyle: GoogleFonts.aBeeZee(
                              color: kGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                )),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
