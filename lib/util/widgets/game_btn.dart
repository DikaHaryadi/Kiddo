import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/responsive.dart';

class GameButton extends StatefulWidget {
  const GameButton({
    required this.title,
    required this.onPressed,
    required this.isActive,
    this.height = 40,
    this.width = double.infinity,
    this.fontSize = 18,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final bool isActive;
  final double height;
  final double width;
  final double fontSize;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool isStarGold = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isStarGold = !isStarGold; // Toggle status bintang
        });
        widget.onPressed(); // Panggil fungsi onPressed dari properti widget
      },
      child: isMobile(context)
          ? AspectRatio(
              aspectRatio: 20 / 6,
              child: Container(
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.height / 2),
                  boxShadow: const [
                    BoxShadow(color: Color(0xFFDFA591), offset: Offset(2, 0)),
                    BoxShadow(color: Color(0xFFE6B6B6), offset: Offset(-2, 0)),
                    BoxShadow(color: Color(0xFFDFB1B5), offset: Offset(0, -2)),
                    BoxShadow(color: Color(0xFF2D396F), offset: Offset(0, 2)),
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFAF0F0),
                      Color(0xFFF9EDEF),
                      Color(0xFFE9E3F2),
                      Color(0xFFEDE3EE),
                      Color(0xFFE2DFF0),
                      Color(0xFFE4E1F1),
                      Color(0xFFDBDBF5)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.7],
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(widget.height / 2),
                        child: Image.asset('assets/images/logo.png')),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        widget.isActive
                            ? const SizedBox.shrink()
                            : const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 45.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.blue),
                              child: Text(
                                '3',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.apply(color: kWhite),
                              ),
                            ),
                            widget.isActive
                                ? const SizedBox.shrink()
                                : const SizedBox(width: 9.0),
                            widget.isActive
                                ? LottieBuilder.asset(
                                    'assets/animations/star_animation.json',
                                    height: 50,
                                  )
                                : const Icon(
                                    Iconsax.star,
                                    color: Colors.white,
                                    size: 30,
                                  )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          : AspectRatio(
              aspectRatio: 20 / 4,
              child: Container(
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.height / 2),
                  boxShadow: const [
                    BoxShadow(color: Color(0xFFDFA591), offset: Offset(2, 0)),
                    BoxShadow(color: Color(0xFFE6B6B6), offset: Offset(-2, 0)),
                    BoxShadow(color: Color(0xFFDFB1B5), offset: Offset(0, -2)),
                    BoxShadow(color: Color(0xFF2D396F), offset: Offset(0, 2)),
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFAF0F0),
                      Color(0xFFF9EDEF),
                      Color(0xFFE9E3F2),
                      Color(0xFFEDE3EE),
                      Color(0xFFE2DFF0),
                      Color(0xFFE4E1F1),
                      Color(0xFFDBDBF5)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.7],
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        widget.isActive
                            ? const SizedBox.shrink()
                            : const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 45.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.blue),
                              child: Text(
                                '3',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.apply(color: kWhite),
                              ),
                            ),
                            widget.isActive
                                ? const SizedBox(
                                    width: 8.0,
                                  )
                                : const SizedBox(width: 17.0),
                            widget.isActive
                                ? LottieBuilder.asset(
                                    'assets/animations/star_animation.json',
                                    height: 50,
                                  )
                                : const Icon(
                                    Iconsax.star,
                                    color: Colors.white,
                                    size: 30,
                                  )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
