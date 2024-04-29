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

// class HomeCurvesEdge extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Layer 1

//     Paint paintFill0 = Paint()
//       ..color = const Color(0xFFffee93)
//       ..style = PaintingStyle.fill
//  ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_0 = Path();
//     path_0.moveTo(size.width * 1.0000375, size.height * 0.6601750);
//     path_0.quadraticBezierTo(size.width * 0.9625750, size.height * 0.6745250,
//         size.width * 0.9500500, size.height * 0.6955417);
//     path_0.quadraticBezierTo(size.width * 0.9244875, size.height * 0.7671083,
//         size.width * 0.8532750, size.height * 0.8041167);
//     path_0.quadraticBezierTo(size.width * 0.7490625, size.height * 0.8561667,
//         size.width * 0.7080875, size.height * 0.8674167);
//     path_0.cubicTo(
//         size.width * 0.6863750,
//         size.height * 0.8727500,
//         size.width * 0.6391125,
//         size.height * 0.8784500,
//         size.width * 0.6161125,
//         size.height * 0.8828250);
//     path_0.quadraticBezierTo(size.width * 0.5916000, size.height * 0.8847667,
//         size.width * 0.5174625, size.height * 0.8957083);
//     path_0.lineTo(size.width * 0.3856125, size.height * 0.9108667);
//     path_0.quadraticBezierTo(size.width * 0.2703750, size.height * 0.9241583,
//         size.width * 0.2330500, size.height * 0.9318417);
//     path_0.quadraticBezierTo(size.width * 0.2106250, size.height * 0.9351250,
//         size.width * 0.1539625, size.height * 0.9561083);
//     path_0.lineTo(size.width * 0.1076000, size.height * 0.9703417);
//     path_0.quadraticBezierTo(size.width * 0.0618000, size.height * 0.9820250,
//         size.width * 0.0588625, size.height * 0.9971917);
//     path_0.quadraticBezierTo(size.width * 0.2935500, size.height * 0.9978917,
//         size.width * 0.9976750, size.height * 1.0000083);
//     path_0.lineTo(size.width * 1.0000375, size.height * 0.6601750);
//     path_0.close();

//     canvas.drawPath(path_0, paintFill0);

//     // Layer 1

//     Paint paintStroke0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.bevel;

//     canvas.drawPath(path_0, paintStroke0);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

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

// class HomeTabletCurvedEdges extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path_0 = Path();
//     path_0.moveTo(size.width * -0.0000500, size.height * 0.0006750);
//     path_0.lineTo(size.width * 0.0008333, size.height * 0.3150000);
//     path_0.quadraticBezierTo(size.width * -0.0007667, size.height * 0.3760125,
//         size.width * 0.0433333, size.height * 0.3762500);
//     path_0.cubicTo(
//         size.width * 0.2721667,
//         size.height * 0.3757500,
//         size.width * 0.7298333,
//         size.height * 0.3747500,
//         size.width * 0.9586667,
//         size.height * 0.3742500);
//     path_0.quadraticBezierTo(size.width * 1.0007083, size.height * 0.3734875,
//         size.width * 0.9991667, size.height * 0.3175000);
//     path_0.lineTo(size.width * 1.0004417, size.height * 0.0000250);
//     path_0.lineTo(size.width * -0.0000500, size.height * 0.0006750);
//     path_0.close();
//     return path_0;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = kHighColor
//       ..style = PaintingStyle.fill;

//     var path = HomeTabletCurvedEdges().getClip(size);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
