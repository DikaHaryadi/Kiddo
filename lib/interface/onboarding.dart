import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:textspeech/interface/intro/intro_page1.dart';
import 'package:textspeech/interface/intro/intro_page2.dart';
import 'package:textspeech/interface/intro/intro_page3.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_pageListerner);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_pageListerner);
    _controller.dispose();
  }

  void _pageListerner() {
    setState(() {
      onLastPage = _controller.page == _controller.page!.roundToDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [IntroPage1(), IntroPage2(), IntroPage3()],
            onPageChanged: (value) {
              setState(() {});
            },
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (onLastPage) {
                        // Lakukan tindakan ketika pengguna berada di halaman terakhir
                        // Misalnya kembali ke halaman sebelumnya
                      } else {
                        // Lakukan tindakan ketika pengguna belum berada di halaman terakhir
                        // Misalnya melewati ke halaman berikutnya
                        _controller.jumpToPage(2);
                      }
                    },
                    child: Text(onLastPage ? 'Sebelumnya' : 'Skip'),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (onLastPage) {
                        // Lakukan tindakan ketika pengguna berada di halaman terakhir
                      } else {
                        // Lakukan tindakan ketika pengguna belum berada di halaman terakhir
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Icon(Icons.skip_next_outlined),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
