import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  const BackgroundDecoration({
    super.key,
    required this.child,
    this.showGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient
                  ? const LinearGradient(
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
                    )
                  : null),
          child: CustomPaint(
            painter: BackgroundPainter(),
          ),
        )),
        Positioned(child: child)
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, size.height * 0.4);
    path.close();

    final path1 = Path();
    path1.moveTo(size.width, 0);
    path1.lineTo(size.width * 0.8, 0);
    path1.lineTo(size.width, size.height);
    path1.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
