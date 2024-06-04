import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/curved_edges.dart';

class InfoAppScreen extends StatelessWidget {
  const InfoAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            ClipPath(
              clipper: InfoAppCurvedEdges(),
              child: Container(
                height: 350, // Tentukan tinggi widget Anda
                width: double.infinity,
                color: const Color.fromARGB(
                    255, 26, 31, 63), // Warna diubah ke rgba(26,31,63,255)
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.width * .12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.activity,
                                color: kWhite,
                              )),
                          Text(
                            'KiddieLearn',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.apply(color: kWhite),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.search_favorite,
                                color: kWhite,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
                top: Get.height * .17,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Information App',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Tim Penyusun',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            'assets/banner_musik.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: AutoSizeText(
                          'Mba Indah',
                          maxFontSize: 14,
                          minFontSize: 12,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: kBlack,
                          ),
                        ),
                        subtitle: const AutoSizeText(
                          'Penulis',
                          maxFontSize: 14,
                          minFontSize: 12,
                        ),
                      ),
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            'assets/banner_musik.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: AutoSizeText(
                          'Mas Bram',
                          maxFontSize: 14,
                          minFontSize: 12,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: kBlack,
                          ),
                        ),
                        subtitle: const AutoSizeText(
                          'Programmer',
                          maxFontSize: 14,
                          minFontSize: 12,
                        ),
                      ),
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            'assets/banner_musik.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: AutoSizeText(
                          'Muhammad Dika Haryadi',
                          maxFontSize: 14,
                          minFontSize: 12,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: kBlack,
                          ),
                        ),
                        subtitle: const AutoSizeText(
                          'Programmer',
                          maxFontSize: 14,
                          minFontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Versi',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                        child: Row(
                          children: [
                            const Icon(Iconsax.verify),
                            const SizedBox(width: 12.0),
                            Text(
                              '1.0.0',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        child: Text(
                          'Contact Us',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                        child: Row(
                          children: [
                            const Icon(Iconsax.message),
                            const SizedBox(width: 12.0),
                            Text(
                              'bramastyodevops@gmail.com',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                        child: Row(
                          children: [
                            const Icon(Iconsax.warning_2),
                            const SizedBox(width: 12.0),
                            Text(
                              'Report Bug',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Text(
                          'Lainnya',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                        child: Row(
                          children: [
                            const Icon(Iconsax.star),
                            const SizedBox(width: 12.0),
                            Text(
                              'Rate us on google play',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                        child: Row(
                          children: [
                            const Icon(Iconsax.card_pos),
                            const SizedBox(width: 12.0),
                            Text(
                              'Criticisms and suggestions',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
