import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/interface/detail%20content/detail_vegetables.dart';
import 'package:textspeech/interface/homepage.dart';

class VegetablesContent extends StatelessWidget {
  const VegetablesContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 250), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            });
          },
          icon: const Icon(Icons.arrow_back_ios)
              .animate(delay: const Duration(milliseconds: 250))
              .slideX(
                  begin: 2,
                  end: 0,
                  duration: const Duration(milliseconds: 300)),
        ),
        title: Text(
          'widget.name',
          style: GoogleFonts.montserratAlternates(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ).animate(delay: const Duration(milliseconds: 250)).slideX(
            begin: 1, end: 0, duration: const Duration(milliseconds: 400)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        children: [
          AspectRatio(
            aspectRatio: 18 / 9,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xFF65d1ff),
                  image:
                      DecorationImage(image: AssetImage('assets/animals.png'))),
            ),
          )
              .animate(delay: const Duration(milliseconds: 250))
              .fadeIn(duration: const Duration(milliseconds: 900)),
          const SizedBox(height: 25.0),
          Text(
            'Text',
            style: GoogleFonts.aBeeZee(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ).animate(delay: const Duration(milliseconds: 250)).slideX(
              begin: 2.5, end: 0, duration: const Duration(milliseconds: 550)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    OpenContainer(
                      openColor: Colors.pink,
                      transitionDuration: const Duration(milliseconds: 500),
                      transitionType: ContainerTransitionType.fade,
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      closedBuilder: (context, action) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.red,
                        );
                      },
                      openBuilder: (context, action) =>
                          const DetailVegetables(),
                    ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'categories[index][]',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            Text(
                              ' categories[index][subtitleContent]',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailVegetables(),
                              ));
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: const Border.fromBorderSide(BorderSide(
                                color: Colors.orange,
                                strokeAlign: 1,
                                width: 1))),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.orange,
                        ),
                      ),
                    )
                  ],
                ),
              ).animate(delay: const Duration(milliseconds: 250)).slideY(
                  begin: 2.5,
                  end: 0,
                  duration: const Duration(milliseconds: 700));
            },
          ),
        ],
      ),
    );
  }
}
