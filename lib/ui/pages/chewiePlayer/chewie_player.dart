import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  String pathVideoUrl;
  ChewieDemo({String pathVideo, Key key})
      : this.pathVideoUrl = pathVideo,
        super(key: key);

  // final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  // VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
// 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.network(widget.pathVideoUrl);
    // _videoPlayerController2 = VideoPlayerController.network(
    //     widget.pathVideoUrl );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    // _chewieController.enterFullScreen();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    // _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('widgetvideourl');
    print(widget.pathVideoUrl);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: widget.title,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // title: Text('Video'),
          leading: IconButton(
              icon: Icon( Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: Colors.orange),
              onPressed: () {
                if (MediaQuery.of(context).orientation ==
                    Orientation.landscape) {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                }

              }),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
