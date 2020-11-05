import 'package:flutter/material.dart';
import 'package:primaxproject/model/trailers.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/ui/pages/chewiePlayer/chewie_player.dart';
import 'package:primaxproject/widgets/seriesormovieswidget/trailer/video_trailer_widget.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../widgets.dart';

class TrailerWidget extends StatefulWidget {
  final List<Trailer> listTrailers;
  const TrailerWidget({
    Key key,
    List<Trailer> listTrailers,
  })  : this.listTrailers = listTrailers,
        super(key: key);

  @override
  _TrailerWidgetState createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  @override
  Widget build(BuildContext context) {
    print('lengthTrailers');
    print(widget?.listTrailers?.length);
    print(SizeConfigs.screenHeight * 0.01);
    return Container(
      width: widget?.listTrailers == null
          ? []
          : widget?.listTrailers?.length == 0
              ? MediaQuery.of(context).size.width * 0
              : SizeConfigs.screenWidth * 100,
      height: widget?.listTrailers == null
          ? []
          : widget?.listTrailers?.length == 0
              ? MediaQuery.of(context).size.height * 0
              : 
              SizeConfigs.isPortrait 
              ? SizeConfigs.screenHeight * 0.39
              : SizeConfigs.screenHeight * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Trailers:'),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget?.listTrailers?.length == 0
                  ? 0
                  : widget?.listTrailers?.length,
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MyCustomRoute(
                        //     widgetBuilder: (context) => VideoTrailerWidget(
                        //         urlVideo: 'http://vod.appcorp.mobi/storage/' +
                        //             widget?.listTrailers[position].videoCover),
                        //   ),
                        // );

                        Navigator.push(
                          context,
                          MyCustomRoute(
                              widgetBuilder: (context) => ChewieDemo(
                                    pathVideo:
                                        'http://vod.appcorp.mobi/storage/' +
                                            widget
                                                ?.listTrailers[position].video,
                                  )
                              //  VideoEpsisodesWidget(
                              //     urlVideo: 'http://vod.appcorp.mobi/storage/' +
                              //         widget?.listEpisodes[positon].video),
                              ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: widget?.listTrailers == null
                                  ? 0
                                  : widget?.listTrailers?.length == 0
                                      ? SizeConfig.blockSizeHorizontal * 0
                                      :  SizeConfigs.screenWidth * 0.6,
                                      // SizeConfig.blockSizeHorizontal * 50,
                              height: widget?.listTrailers == null
                                  ? 0
                                  : widget?.listTrailers?.length == 0
                                      ? SizeConfig.blockSizeVertical * 0
                                      : SizeConfigs.screenHeight * 0.2,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                      color: AppColorsStyle.colorBorder),
                                  borderRadius: BorderRadius.circular(0)),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            left: 9.5,
                            top: 10,
                            bottom: 10,
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 50,
                              height: SizeConfig.blockSizeVertical * 15,
                              child:
                                Stack(
                            children: [
                                 Positioned(
                                  left: SizeConfigs.screenWidth * 0.25,
                                  top: SizeConfigs.screenWidth * 0.25,
                                  child:  Icon(Icons.error)),
                            Center(
                              child: Container(
                                width: SizeConfigs.imageSizeMultiplier * 45,
                                height: SizeConfigs.screenHeight * 0.25,
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: 'http://vod.appcorp.mobi/storage/' +
                                       widget?.listTrailers[position]?.videoCover,
                                ),
                              ),
                            ),
                          ]), 
                              // CachedNetworkImage(
                              //   imageUrl: 'http://vod.appcorp.mobi/storage/' +
                              //       widget?.listTrailers[position]?.videoCover,
                              //   fit: BoxFit.fill,
                              //   placeholder: (context, url) =>
                              //       CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) =>
                              //       new Icon(Icons.error),
                              // ),
                            ),
                          ),
                          Positioned(
                            top: SizeConfigs.screenHeight * 0.07,
                            // SizeConfigs.isPortrait ?
                            // SizeConfigs.screenHeight * 0.5
                            // : SizeConfigs.screenHeight * 15.0,
                            // MediaQuery.of(context).size.height * 0.05,
                            left: SizeConfigs.screenHeight * 0.125,
                            child: IconButton(
                              icon: Icon(Icons.play_circle_filled),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MyCustomRoute(
                                      widgetBuilder: (context) => ChewieDemo(
                                            pathVideo:
                                                'http://vod.appcorp.mobi/storage/' +
                                                    widget
                                                        ?.listTrailers[position]
                                                        .video,
                                          )
                                      //  VideoEpsisodesWidget(
                                      //     urlVideo: 'http://vod.appcorp.mobi/storage/' +
                                      //         widget?.listEpisodes[positon].video),
                                      ),
                                );
                              },
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget?.listTrailers[position]?.title,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '(Trailer ${widget?.listTrailers[position].position})'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
