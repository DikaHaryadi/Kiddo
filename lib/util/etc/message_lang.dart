import 'package:get/get.dart';

class MessageLang extends Translations {
  final Map<String, Map<String, String>> languages;
  MessageLang({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}
