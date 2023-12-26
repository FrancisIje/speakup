import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String videoPath;
  // final String? closedCaptionPath;
  const VideoWidget({
    super.key,
    required this.videoPath,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _controller;
  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final String fileContents = await DefaultAssetBundle.of(context)
  //       .loadString(
  //         widget.closedCaptionPath!);
  //   return WebVTTCaptionFile(
  //       fileContents); // For vtt files, use WebVTTCaptionFile
  // }

  // Future<ClosedCaptionFile> _loadCaptions(String path) async {
  //   // final String fileContents = await rootBundle.loadString(path);
  //   final String fileContents =
  //       await rootBundle.loadString('assets/subtitles.vtt');

  //   // Bundle

  //   // await DefaultAssetBundle.of(context).loadString(path);
  //   return WebVTTCaptionFile(fileContents);
  // }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      widget.videoPath,
      // closedCaptionFile: widget.closedCaptionPath != null
      //     ? _loadCaptions(widget.closedCaptionPath!)
      //     : null,
      // closedCaptionFile:
      //     widget.closedCaptionPath == null ? null : _loadCaptions()
    );

    _controller!.addListener(() {
      // setState(() {});
    });
    _controller!.setLooping(true);
    _controller!.initialize();
    // .then((_) => setState(() {}));
    _controller!.play();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 1.7,

        // aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            _controller == null
                ? Image.asset("images/womanpurple.png")
                : VideoPlayer(_controller!),
            // _ControlsOverlay(controller: _controller),
            // VideoProgressIndicator(_controller, allowScrubbing: true),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  // static const List<Duration> _exampleCaptionOffsets = <Duration>[
  //   Duration(seconds: -10),
  //   Duration(seconds: -3),
  //   Duration(seconds: -1, milliseconds: -500),
  //   Duration(milliseconds: -250),
  //   Duration.zero,
  //   Duration(milliseconds: 250),
  //   Duration(seconds: 1, milliseconds: 500),
  //   Duration(seconds: 3),
  //   Duration(seconds: 10),
  // ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
