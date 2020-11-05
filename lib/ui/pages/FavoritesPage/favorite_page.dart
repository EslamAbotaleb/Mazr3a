import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/models.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/drawerwidget/drawer_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoritePage extends StatefulWidget {
  // String userId;
  FavoritePage({Key key})
      :
        // this.userId = userId,
        super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  APIResponse<ListFavouriteModel> _apiResponseForretreiveFavoriteList;
  AppServices get service => GetIt.I<AppServices>();
  var heightspace = 15.0;
  var widthSpace = 15.0;
  var widthSpaceText = 7.0;
  bool _isLoading;
  _fetchTopicBecomeFavorite() async {
    setState(() {
      _isLoading = true;
    });

    // widget.userId == null ? '' : widget.userId
    // if (_apiResponseForretreiveFavoriteList.data != null) {
    //   _apiResponseForretreiveFavoriteList.data.results.clear();
    // }
    
    _apiResponseForretreiveFavoriteList =
        await service.getFavoriteList('ISLAMIC-USER-56');

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTopicBecomeFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black87.withOpacity(0.20),
        ),
        child: Container(
          width: SizeConfigs.screenWidth * 100,
          child: DrawerContent(
            widthSpace: widthSpace,
            heightspace: heightspace,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(17, 17, 17, 1.0),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.orange,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            centerTitle: true,
            title: Image.asset(
              'assets/images/primaxPresentationZainWhite01.png',
              fit: BoxFit.fill,
            ),
            expandedHeight: SizeConfigs.heightMultiplier * 17,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50,
            backgroundColor: AppColorsStyle.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    width: SizeConfigs.screenWidth * 100,
                    height: SizeConfigs.screenHeight * 10,
                    color: AppColorsStyle.mainColor,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                         DemoLocalization.of(context).getTransaltedValue('Favorites') ,
                          style: AppTextStyle.titleWithUnderline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Icon(
              //     Icons.search,
              //     color: Colors.orange,
              //   ),
              // ),
            ],
          ),
          new SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: SizeC,
                  color: Color.fromRGBO(17, 17, 17, 1.0),
                  child: Container(
                    width: SizeConfigs.screenWidth * 100,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount:
                        
                       _apiResponseForretreiveFavoriteList?.data ==
                              null
                          ? 0
                          //  _apiResponseForretreiveFavoriteList.data.results.length,
                          :
                          _apiResponseForretreiveFavoriteList?.data?.results == [] ? [] :
                          _apiResponseForretreiveFavoriteList
                                      ?.data?.results?.length ==
                                  0
                              ? 0
                              : _apiResponseForretreiveFavoriteList
                                  .data?.results?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.height <=
                                        667.0
                                    ? MediaQuery.of(context).size.height * 0.22
                                    : MediaQuery.of(context).size.height * 0.18,
                                child:
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
                                      _apiResponseForretreiveFavoriteList
                                          ?.data?.results[index]?.mPoster1,
                                ),
                              ),
                            ),
                          ]),
                                //  CachedNetworkImage(
                                //   imageUrl: 'http://vod.appcorp.mobi/storage/' +
                                //       _apiResponseForretreiveFavoriteList
                                //           ?.data?.results[index]?.mPoster1,
                                //   fit: BoxFit.fill,
                                //   placeholder: (context, url) => Container(
                                //     width: 50,
                                //     height: 50,
                                //     child: Center(
                                //       child: CircularProgressIndicator(),
                                //     ),
                                //   ),
                                //   errorWidget: (context, url, error) =>
                                //       new Icon(Icons.error),
                                // ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 3.0),
                                child: Text(
                                  DemoLocalization.of(context).locale.languageCode == 'en'
                                  ? 
                                  _apiResponseForretreiveFavoriteList
                                      ?.data?.results[index]?.nameEn
                                      :
                                       _apiResponseForretreiveFavoriteList
                                      ?.data?.results[index]?.name
                                      ,
                                  style: AppTextStyle.textCardStyle,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
