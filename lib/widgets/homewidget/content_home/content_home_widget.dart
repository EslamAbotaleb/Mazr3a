import 'package:flutter/material.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/widgets/homewidget/movies_home_widget/movie_home_widget.dart';
import 'package:primaxproject/widgets/homewidget/show_genres_topic_widget/show_genres_widget.dart';
import '../../widgets.dart';

class ContentHomeWidget extends StatefulWidget {
    // APIResponse<ShowTopicModel> getTopicAfterUserSearchedOnSpesficTopic;
    //     APIResponse<ShowTopicModel> filterByMovie;
  String userId;
   ContentHomeWidget({
    Key key,
    String userId,
    // APIResponse<ShowTopicModel> filterByMovie
  }) : 
  this.userId = userId,
  // getTopicAfterUserSearchedOnSpesficTopic = getTopicAfterUserSearchedOnSpesficTopic,
  // filterByMovie = filterByMovie,
  super(key: key);

  @override
  _ContentHomeWidgetState createState() => _ContentHomeWidgetState();
}

class _ContentHomeWidgetState extends State<ContentHomeWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfigs.screenWidth * 100,
      // height: SizeConfigs.screenHeight * 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          
          // widget.getTopicAfterUserSearchedOnSpesficTopic == null 
          // ? 
          TopTenWidget(userId: widget.userId),
          // : TopTenWidget(apiResponse: widget.getTopicAfterUserSearchedOnSpesficTopic),

          // widget.filterByMovie == null ?
            ShowMovieWidgetHome(
            titleSection: DemoLocalization.of(context).getTransaltedValue("Movies"),
            userId: widget.userId
            ),
          // // )
          // // :
          //  ShowMovieWidgetHome(
          //   titleSection: 'movie',
          //   filterByMovie: widget.filterByMovie,
          // ),
           ShowTopicSeriesWidgetHome(
            titleSection: DemoLocalization.of(context).getTransaltedValue("Series"),
            userId: widget.userId
          ),

          ShowGenresTopicWidget(
                        userId: widget.userId

          ),
        ],
      ),
    );
  }
}
