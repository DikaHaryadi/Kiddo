String toTitleCase(String text) {
  if (text.isEmpty) return text;

  // Split by space and process each word separately
  List<String> words = text.split(' ');

  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      // Convert the first character to uppercase and concatenate with the rest of the word
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
  }

  return words.join(' ');
}
