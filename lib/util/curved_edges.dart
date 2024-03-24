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

class KananCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.0002977);
    path_1.lineTo(size.width * 0.5585922, size.height * -0.0002583);
    path_1.quadraticBezierTo(size.width * 0.5635523, size.height * 0.0459631,
        size.width * 0.6131756, size.height * 0.0621311);
    path_1.cubicTo(
        size.width * 0.7535956,
        size.height * 0.1247984,
        size.width * 0.6683516,
        size.height * 0.1365769,
        size.width * 0.7311214,
        size.height * 0.1629871);
    path_1.cubicTo(
        size.width * 0.8534786,
        size.height * 0.1959961,
        size.width * 0.7515000,
        size.height * 0.2118167,
        size.width * 0.8554978,
        size.height * 0.2455974);
    path_1.quadraticBezierTo(size.width * 0.9241625, size.height * 0.2625083,
        size.width * 0.9991879, size.height * 0.2949207);
    path_1.lineTo(size.width, size.height * 0.0002977);
    path_1.close();
    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class KiriCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_1 = Path();
    path_1.moveTo(size.width * 0.0001250, size.height * 0.0002167);
    path_1.lineTo(size.width * -0.0006375, size.height * 0.2944917);
    path_1.quadraticBezierTo(size.width * 0.0686875, size.height * 0.2911750,
        size.width * 0.0929375, size.height * 0.2580917);
    path_1.cubicTo(
        size.width * 0.1869125,
        size.height * 0.1644667,
        size.width * 0.2045875,
        size.height * 0.2212917,
        size.width * 0.2442000,
        size.height * 0.1794500);
    path_1.cubicTo(
        size.width * 0.2937000,
        size.height * 0.0978667,
        size.width * 0.3174375,
        size.height * 0.1658500,
        size.width * 0.3681000,
        size.height * 0.0965167);
    path_1.quadraticBezierTo(size.width * 0.3934500, size.height * 0.0507333,
        size.width * 0.4420500, size.height * 0.0007083);
    path_1.lineTo(size.width * 0.0001250, size.height * 0.0002167);
    path_1.close();
    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HomeCurvesEdge extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 221, 242, 253)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0000375, size.height * 0.6601750);
    path_0.quadraticBezierTo(size.width * 0.9625750, size.height * 0.6745250,
        size.width * 0.9500500, size.height * 0.6955417);
    path_0.quadraticBezierTo(size.width * 0.9244875, size.height * 0.7671083,
        size.width * 0.8532750, size.height * 0.8041167);
    path_0.quadraticBezierTo(size.width * 0.7490625, size.height * 0.8561667,
        size.width * 0.7080875, size.height * 0.8674167);
    path_0.cubicTo(
        size.width * 0.6863750,
        size.height * 0.8727500,
        size.width * 0.6391125,
        size.height * 0.8784500,
        size.width * 0.6161125,
        size.height * 0.8828250);
    path_0.quadraticBezierTo(size.width * 0.5916000, size.height * 0.8847667,
        size.width * 0.5174625, size.height * 0.8957083);
    path_0.lineTo(size.width * 0.3856125, size.height * 0.9108667);
    path_0.quadraticBezierTo(size.width * 0.2703750, size.height * 0.9241583,
        size.width * 0.2330500, size.height * 0.9318417);
    path_0.quadraticBezierTo(size.width * 0.2106250, size.height * 0.9351250,
        size.width * 0.1539625, size.height * 0.9561083);
    path_0.lineTo(size.width * 0.1076000, size.height * 0.9703417);
    path_0.quadraticBezierTo(size.width * 0.0618000, size.height * 0.9820250,
        size.width * 0.0588625, size.height * 0.9971917);
    path_0.quadraticBezierTo(size.width * 0.2935500, size.height * 0.9978917,
        size.width * 0.9976750, size.height * 1.0000083);
    path_0.lineTo(size.width * 1.0000375, size.height * 0.6601750);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.bevel;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class KiriBawahCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_1 = Path();
    path_1.moveTo(size.width * 0.0006000, size.height * 0.9998917);
    path_1.lineTo(size.width * 0.4410125, size.height * 1.0003833);
    path_1.quadraticBezierTo(size.width * 0.4361375, size.height * 0.9541667,
        size.width * 0.3865375, size.height * 0.9379583);
    path_1.cubicTo(
        size.width * 0.2462125,
        size.height * 0.8751833,
        size.width * 0.3314875,
        size.height * 0.8634667,
        size.width * 0.2687625,
        size.height * 0.8370167);
    path_1.cubicTo(
        size.width * 0.1464750,
        size.height * 0.8039000,
        size.width * 0.2484875,
        size.height * 0.7881583,
        size.width * 0.1445250,
        size.height * 0.7543000);
    path_1.quadraticBezierTo(size.width * 0.0759125, size.height * 0.7373333,
        size.width * 0.0009375, size.height * 0.7048583);
    path_1.lineTo(size.width * 0.0006000, size.height * 0.9998917);
    path_1.close();
    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class KananBawahCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0004375, size.height * 0.9991500);
    path_0.lineTo(size.width * 1.0000750, size.height * 0.7048833);
    path_0.quadraticBezierTo(size.width * 0.9307750, size.height * 0.7083083,
        size.width * 0.9066500, size.height * 0.7414333);
    path_0.cubicTo(
        size.width * 0.8130375,
        size.height * 0.8352250,
        size.width * 0.7951375,
        size.height * 0.7784167,
        size.width * 0.7556875,
        size.height * 0.8203417);
    path_0.cubicTo(
        size.width * 0.7065000,
        size.height * 0.9019917,
        size.width * 0.6824875,
        size.height * 0.8340500,
        size.width * 0.6321000,
        size.height * 0.9034750);
    path_0.quadraticBezierTo(size.width * 0.6069125, size.height * 0.9492917,
        size.width * 0.5585000, size.height * 0.9994000);
    path_0.lineTo(size.width * 1.0004375, size.height * 0.9991500);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class AtasCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0005000, size.height * 0.2078333);
    path_0.quadraticBezierTo(size.width * 0.1214375, size.height * 0.1928333,
        size.width * 0.1617500, size.height * 0.1878333);
    path_0.quadraticBezierTo(size.width * 0.2428125, size.height * 0.1767500,
        size.width * 0.3265000, size.height * 0.1988333);
    path_0.cubicTo(
        size.width * 0.4915625,
        size.height * 0.1560833,
        size.width * 0.5984375,
        size.height * 0.1537500,
        size.width * 0.7117500,
        size.height * 0.1885000);
    path_0.quadraticBezierTo(size.width * 0.8759375, size.height * 0.1845833,
        size.width * 1.0005000, size.height * 0.2075000);
    path_0.lineTo(size.width * 1.0007500, size.height * 0.0001667);
    path_0.lineTo(size.width * 0.0005000, size.height * 0.0005000);
    path_0.quadraticBezierTo(size.width * 0.0005000, size.height * 0.0523333,
        size.width * 0.0005000, size.height * 0.2078333);
    path_0.close();
    return path_0;
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
