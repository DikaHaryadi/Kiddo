import 'package:flutter/material.dart';

class Drop extends StatefulWidget {
  const Drop({
    required this.letter,
    Key? key,
  }) : super(key: key);

  final String letter;

  @override
  _DropState createState() => _DropState();
}

class _DropState extends State<Drop> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.15,
      height: size.height * 0.15,
      child: Center(
        child: DragTarget(onWillAccept: (data) {
          if (data == widget.letter) {
            return true;
          } else {
            return false;
          }
        }, onAccept: (data) {
          setState(() {
            accepted = true;
          });
        }, builder: (context, candidateData, rejectedData) {
          if (accepted) {
            return Text(
              widget.letter,
              style: Theme.of(context).textTheme.displayLarge,
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.amber,
              ),
              width: 50,
              height: 50,
            );
          }
        }),
      ),
    );
  }
}
