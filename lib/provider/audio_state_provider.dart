import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AudioProvider with ChangeNotifier {
  bool _isTalking = false;
  late AudioPlayer _audioPlayer;

  bool get isTalking => _isTalking;

  void changeTalkingBool(bool newValue) {
    _isTalking = newValue;
    notifyListeners();
  }

  void playAudioFile(Uint8List bytes) async {
    _audioPlayer = AudioPlayer();

    changeTalkingBool(true);

    await _audioPlayer.play(BytesSource(bytes));

    _audioPlayer.onPlayerComplete.listen((event) {
      changeTalkingBool(false);
    });
  }

  void stopAudio() {
    _audioPlayer.stop();
    changeTalkingBool(false);
  }
}
