// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoState extends ChangeNotifier {
//   VideoPlayerController? _speakingController;
//   VideoPlayerController? _listeningController;

//   bool get isInitialized =>
//       _speakingController != null && _listeningController != null;

//   VideoPlayerController? get controller =>
//       isTalking ? _speakingController : _listeningController;

//   bool isTalking = false;

//   void initializeControllers() {
//     _speakingController =
//         VideoPlayerController.asset("videos/speaking_woman.mp4");
//     _listeningController =
//         VideoPlayerController.asset("videos/listening_woman.mp4");

//     _speakingController!.initialize().then((_) {
//       notifyListeners();
//     });
//     _listeningController!.initialize().then((_) {
//       notifyListeners();
//     });
//   }

//   void setTalking(bool value) {
//     isTalking = value;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _speakingController?.dispose();
//     _listeningController?.dispose();
//     super.dispose();
//   }
// }
