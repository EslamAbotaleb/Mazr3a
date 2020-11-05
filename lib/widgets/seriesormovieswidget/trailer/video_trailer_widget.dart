// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:primaxapp/res/sizeconfig.dart';
// import 'package:primaxapp/srcvideo/neeko_player_widget.dart';
// import 'package:primaxapp/srcvideo/video_controller_wrapper.dart';

// import '../../widgets.dart';

// class VideoTrailerWidget extends StatefulWidget {
//   final String _urlVideo;

//   const VideoTrailerWidget({Key key, String urlVideo})
//       : _urlVideo = urlVideo,
//         super(key: key);

//   @override
//   _VideoTrailerWidgetState createState() => _VideoTrailerWidgetState();
// }

// class _VideoTrailerWidgetState extends State<VideoTrailerWidget> {

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
//   }

//   @override
//   void dispose() {
//     SystemChrome.restoreSystemUIOverlays();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final VideoControllerWrapper videoControllerWrapper =
//         VideoControllerWrapper(DataSource.network(widget._urlVideo));
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: SizeConfig.blockSizeHorizontal * 100,
//           height: SizeConfig.blockSizeVertical * 50,
//           child: NeekoPlayerWidget(
//             videoControllerWrapper: videoControllerWrapper,
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(
//                   Icons.cancel,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   SystemChrome.setPreferredOrientations([
//                     DeviceOrientation.portraitUp,
//                     DeviceOrientation.portraitDown,
//                   ]);
//                   videoControllerWrapper.controller.pause();
//                   Future.delayed(const Duration(milliseconds: 200), () {
//                     setState(
//                       () {
//                         // Here you can write your code for open new view
//                         Navigator.push(
//                           context,
//                           MyCustomRoute(
//                             widgetBuilder: (context) =>
//                                 SelectedTopicSeriesOrMovie(type: 'movie',),
//                           ),
//                         );
//                       },
//                     );
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
