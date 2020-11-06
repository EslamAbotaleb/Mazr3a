import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/autorotate/auto_rotate.dart';
import 'package:primaxproject/model/episodes.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/ui/pages/chewiePlayer/chewie_player.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

import '../../widgets.dart';

class EpisodesWidget extends StatefulWidget {
  final List<Episode> listEpisodes;

  const EpisodesWidget({
    Key key,
    List<Episode> listEpisodes,
  })  : this.listEpisodes = listEpisodes,
        super(key: key);

  @override
  _SeeEpisodesWidgetState createState() => _SeeEpisodesWidgetState();
}

class _SeeEpisodesWidgetState extends State<EpisodesWidget> {
  AppServices get service => GetIt.I<AppServices>();
  ScrollController _scrollController = ScrollController();
  int pageNumber = 1;
  VideoPlayerController _videoPlayerController1;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    // _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: Container(
        width: widget?.listEpisodes == null
            ? 0
            : widget?.listEpisodes?.length == 0
                ? SizeConfig.blockSizeHorizontal * 0
                : SizeConfig.blockSizeHorizontal * 100,
        height: widget?.listEpisodes == null
            ? 0
            : widget?.listEpisodes?.length == 0
                ? SizeConfig.blockSizeVertical * 0
                : 300.8,

        decoration: BoxDecoration(
          color: Color.fromRGBO(17, 17, 17, 1.0),
          border: Border(
            bottom: BorderSide(color: AppColorsStyle.lineColorContainer),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('See All Episodes:'),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemExtent: 0.40 * MediaQuery.of(context).size.width, 
                  // MediaQuery.of(context).size.width <= 375.0
                  //   ? 0.45 * MediaQuery.of(context).size.width
                  //   : 0.45 * MediaQuery.of(context).size.width,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget?.listEpisodes?.length == 0
                      ? 0
                      : widget?.listEpisodes?.length,

                  itemBuilder: (BuildContext context, int positon) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MyCustomRoute(
                            widgetBuilder: (context) =>
                            ChewieDemo(pathVideo: 'http://vod.appcorp.mobi/storage/' +
                                    widget?.listEpisodes[positon].video,)
                            //  VideoEpsisodesWidget(
                            //     urlVideo: 'http://vod.appcorp.mobi/storage/' +
                            //         widget?.listEpisodes[positon].video),
                          ),
                        );

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.14),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(
                                width: SizeConfig.blockSizeHorizontal * 45,
                                height: 210.0,
                                //  SizeConfig.blockSizeVertical * 23,
                                child:
                                //  CachedNetworkImage(
                                //   imageUrl:
                                //       'http://vod.appcorp.mobi/storage/' +
                                //           widget?.listEpisodes[positon]?.videoCover,
                                //   fit: BoxFit.fill,
                                //   placeholder: (context, url) =>
                                //       CircularProgressIndicator(),
                                //   errorWidget: (context, url, error) =>
                                //       new Icon(Icons.error),
                                // ),
                                  Stack(
                            children: [
                                 Positioned(
                                  left: SizeConfigs.screenWidth * 0.158,
                                  top: SizeConfigs.screenWidth * 0.158,
                                  child:  Icon(Icons.error)),
                            Center(
                              child: Container(
                                width: SizeConfigs.imageSizeMultiplier * 45,
                                height: SizeConfigs.screenHeight * 0.25,
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: 'http://vod.appcorp.mobi/storage/' +
                                      widget?.listEpisodes[positon]?.videoCover,
                                ),
                              ),
                            ),
                          ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    widget?.listEpisodes[positon]?.title,
                                     style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // } catch (error) {
    //   return Container(
    //     width: 50,
    //     height: 50,
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
  }
}
