import 'package:flutter/material.dart';
import 'package:textspeech/util/curved_edges.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SafeArea(
            child: ClipPath(
              clipper: KiriCurvedEdges(),
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Positioned(
              top: 50,
              right: 20,
              width: 100,
              child: SafeArea(
                  child: Image.asset('assets/images/Logo_color1.png'))),
          Positioned(
              left: 50,
              right: 50,
              top: 280,
              bottom: 280,
              child: Container(
                alignment: Alignment.center,
                height: 200,
                width: 100,
                color: Colors.yellow,
                child: Text('Content Disini'),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipPath(
              clipper: KananBawahCurvedEdges(),
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
