// import 'package:get/get.dart';
// import 'package:audioplayers/audioplayers.dart';

// import '../models/animal_model.dart';

// class AudioController extends GetxController {
//   var isPlaying = false.obs;
//   late final AudioPlayer player;
//   RxString audioPlay = ''.obs;
//   Rx<AnimalModel> animal = AnimalModel.empty().obs;

//   var duration = const Duration().obs;
//   var position = const Duration().obs;
//   var currentIndex = -1.obs;

//   @override
//   void onInit() {
//     initPlayer();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     player.dispose();
//     super.onClose();
//   }

//   Future<void> initPlayer() async {
//     player = AudioPlayer();

//     player.onDurationChanged.listen((Duration d) {
//       duration.value = d;
//     });

//     player.onPositionChanged.listen((Duration p) {
//       position.value = p;
//     });

//     player.onPlayerComplete.listen((_) {
//       isPlaying.value = false;
//       position.value = duration.value;
//     });

//     // Menginisialisasi durasi saat halaman pertama kali dibuka
//     final initialDuration = await getAudioDuration();
//     duration.value = initialDuration;
//   }

//   Future<Duration> getAudioDuration() async {
//     await player.setSource(UrlSource(audioPlay.value));
//     final duration = await player.getDuration();
//     if (duration != null) {
//       return duration;
//     } else {
//       return const Duration();
//     }
//   }

//   Future<Duration> getAudioPosition() async {
//     return position.value;
//   }

//   void playPause() async {
//     if (isPlaying.value) {
//       player.pause();
//       isPlaying.value = false;
//     } else {
//       player.play(UrlSource(audioPlay.value));
//       isPlaying.value = true;
//     }
//   }

//   Future<void> seek(double value) async {
//     await player.seek(Duration(seconds: value.toInt()));
//   }

//   Future<void> seekBackward() async {
//     if (position.value.inSeconds >= 10) {
//       await player.seek(Duration(seconds: position.value.inSeconds - 10));
//     } else {
//       await player.seek(const Duration(seconds: 0));
//     }
//   }

//   Future<void> seekForward() async {
//     if (position.value.inSeconds < duration.value.inSeconds - 10) {
//       await player.seek(Duration(seconds: position.value.inSeconds + 10));
//     } else {
//       await player.seek(duration.value);
//     }
//   }
// }

// extension FormatString on Duration {
//   String format() => toString().substring(2, 7);
// }
