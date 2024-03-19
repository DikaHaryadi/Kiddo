import 'dart:async';

import 'package:flutter/material.dart';
import 'package:textspeech/util/widgets/card_item.dart';

class MemoryCard extends StatefulWidget {
  const MemoryCard({
    Key? key,
    required this.card,
    required this.index,
    required this.onCardPressed,
  }) : super(key: key);

  final CardItem card;
  final int index;
  final ValueChanged<int> onCardPressed;

  @override
  // ignore: library_private_types_in_public_api
  _MemoryCardState createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleCardTap() {
    if (widget.card.state == CardState.hidden) {
      Timer(const Duration(milliseconds: 100), () {
        widget.onCardPressed(widget.index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.card.state == CardState.visible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return InkWell(
          onTap: _handleCardTap,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(_animation.value * 3.14),
            alignment: Alignment.center,
            child: Card(
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: widget.card.state == CardState.visible
                    ? const BorderSide(
                        color: Colors.white,
                        width: 5,
                        style: BorderStyle.solid,
                      )
                    : const BorderSide(color: Colors.blue, width: 1),
              ),
              color: widget.card.state == CardState.visible ||
                      widget.card.state == CardState.guessed
                  ? widget.card.color
                  : Colors.grey,
              child: Center(
                child: widget.card.state == CardState.hidden
                    ? null
                    : SizedBox.expand(
                        child: FittedBox(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.diagonal3Values(
                                -1, 1, 1), // mirror image horizontally
                            child: Icon(
                              widget.card.icon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
