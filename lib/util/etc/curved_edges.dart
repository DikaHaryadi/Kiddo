import 'package:flutter/material.dart';

class TCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy,
        thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class FamilyCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0002500, size.height * 0.4324333);
    path_0.quadraticBezierTo(size.width * 0.0027500, size.height * 0.4585250,
        size.width * 0.0478375, size.height * 0.4815500);
    path_0.cubicTo(
        size.width * 0.0749750,
        size.height * 0.4945833,
        size.width * 0.1136125,
        size.height * 0.5066750,
        size.width * 0.1488500,
        size.height * 0.5125917);
    path_0.cubicTo(
        size.width * 0.2123375,
        size.height * 0.5283250,
        size.width * 0.8458875,
        size.height * 0.5216333,
        size.width * 0.9031000,
        size.height * 0.5247167);
    path_0.cubicTo(
        size.width * 0.9479750,
        size.height * 0.5261917,
        size.width * 0.9616000,
        size.height * 0.5439000,
        size.width * 0.9709000,
        size.height * 0.5514667);
    path_0.quadraticBezierTo(size.width * 0.9820000, size.height * 0.5602500,
        size.width * 0.9999000, size.height * 0.5840000);
    path_0.lineTo(size.width * 1.0012500, size.height * -0.0007667);
    path_0.lineTo(size.width * 0.0003500, size.height * 0.0002000);
    path_0.lineTo(size.width * 0.0002500, size.height * 0.4324333);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
