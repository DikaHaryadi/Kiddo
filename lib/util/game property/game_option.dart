import 'package:flutter/material.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/game%20property/game_board_mobile.dart';
import 'package:textspeech/util/widgets/game_btn.dart';

class GameOptions extends StatelessWidget {
  const GameOptions({
    super.key,
  });

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
    return MaterialPageRoute(
      builder: (_) {
        return GameBoardMobile(gameLevel: gameLevel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gameLevels.map((level) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GameButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                _routeBuilder(context, level['level']),
                (Route<dynamic> route) => false),
            title: level['title'],
            color: level['color']![700]!,
            width: 250,
          ),
        );
      }).toList(),
    );
  }
}

// class NumberOptions extends StatelessWidget {
//   const NumberOptions({
//     super.key,
//   });

//   static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
//     return MaterialPageRoute(
//       builder: (_) {
//         return NumbersGame(gameLevel: gameLevel);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: numberLevels.map((level) {
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: GameButton(
//             onPressed: () => Navigator.of(context).pushAndRemoveUntil(
//                 _routeBuilder(context, level['digits']),
//                 (Route<dynamic> route) => false),
//             title: level['title'],
//             color: level['color']![700]!,
//             width: 250,
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
