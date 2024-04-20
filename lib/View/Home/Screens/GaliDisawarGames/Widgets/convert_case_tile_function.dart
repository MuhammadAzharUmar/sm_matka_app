class ConvertToTitleCase{
  static String convertToTitleCase(String text) {
    List<String> words = text.split('_');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalizedWord = word.substring(0, 1).toUpperCase() +
            word.substring(1).toLowerCase();
        capitalizedWords.add(capitalizedWord);
      }
    }

    return capitalizedWords.join(' ');
  }
}