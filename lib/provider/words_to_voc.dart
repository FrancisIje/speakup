import 'package:flutter/foundation.dart';

class WordsProvider with ChangeNotifier {
  List<String>? _wordsToAddList;

  List<String>? get wordsToAddList => _wordsToAddList;

  // Constructor to initialize the list
  WordsProvider() {
    _wordsToAddList = [];
  }

  // Method to add a new word to the list
  void addWord(String word) {
    _wordsToAddList?.add(word);
    notifyListeners();
  }
}
