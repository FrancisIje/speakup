import 'package:flutter/foundation.dart';

class WordsProvider with ChangeNotifier {
  final List<String> _wordsToAddList = [];

  List<String> get wordsToAddList => _wordsToAddList;

  // Method to add a new word to the list
  void addWord(String word) {
    _wordsToAddList.add(word);
    notifyListeners();
  }
}
