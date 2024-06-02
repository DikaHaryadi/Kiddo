import 'package:flutter/material.dart';
import 'package:textspeech/util/etc/constants.dart';
import 'package:textspeech/util/widgets/game_btn.dart';

class GameOptions extends StatefulWidget {
  const GameOptions({Key? key, required this.onLevelSelected})
      : super(key: key);

  final ValueChanged<int?> onLevelSelected;

  @override
  // ignore: library_private_types_in_public_api
  _GameOptionsState createState() => _GameOptionsState();
}

class _GameOptionsState extends State<GameOptions> {
  int? activeIndex; // Menyimpan indeks tombol yang aktif

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gameLevels.asMap().entries.map((entry) {
        int index = entry.key;
        var level = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: GameButton(
            onPressed: () {
              setState(() {
                activeIndex =
                    index; // Set activeIndex ke indeks tombol yang diklik
              });
              widget.onLevelSelected(activeIndex);
            },
            title: level['title'],
            level: level['kesulitan'],
            width: 250,
            isActive:
                activeIndex == index, // Kirim status aktif berdasarkan indeks
          ),
        );
      }).toList(),
    );
  }
}
