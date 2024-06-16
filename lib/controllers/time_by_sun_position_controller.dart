import 'package:get/get.dart';

class TimeSunPosition extends GetxController {
  final RxString timeOfDay = ''.obs;

  @override
  void onInit() {
    getTimeOfDay();
    super.onInit();
  }

  getTimeOfDay() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour >= 4 && hour < 12) {
      timeOfDay.value = 'Pagi';
    } else if (hour >= 12 && hour < 17) {
      timeOfDay.value = 'Sore';
    } else if (hour >= 17 && hour < 20) {
      timeOfDay.value = 'Evening';
    } else {
      timeOfDay.value = 'Malam';
    }
  }
}
