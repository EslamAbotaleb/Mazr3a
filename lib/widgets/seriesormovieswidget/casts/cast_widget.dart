import 'package:flutter/material.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/cast.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:transparent_image/transparent_image.dart';

class CastWidget extends StatefulWidget {
  List<Cast> listCast;
  List<Cast> listMainStars;
  String titleSection;
  CastWidget(
      {Key key,
      List<Cast> listCast,
      List<Cast> listMainStars,
      String titleSection})
      : this.listCast = listCast,
        this.titleSection = titleSection,
        this.listMainStars = listMainStars,
        super(key: key);

  @override
  _CastWidgetState createState() => _CastWidgetState();
}

class _CastWidgetState extends State<CastWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget?.listCast == null
          ? []
          : widget?.listCast?.length == 0
              ? SizeConfigs.screenWidth *  0.0
              : SizeConfigs.screenWidth * 100.0,
      height: widget?.listCast == null
          ? []
          : widget?.listCast?.length == 0
              ? SizeConfigs.screenHeight * 0
              : SizeConfigs.screenHeight * 0.25,
      decoration: BoxDecoration(
        color: Color.fromRGBO(17, 17, 17, 1.0),
        border: Border(
          bottom: BorderSide(color: AppColorsStyle.lineColorContainer),
          top: BorderSide(color: AppColorsStyle.lineColorContainer),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget?.titleSection),
          ),
          Expanded(
            flex: 1,
                      child: ListView.builder(
              itemCount:
                  widget?.listCast?.length == 0 ? 0 : widget?.listCast?.length,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int position) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(
                        // borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width:  SizeConfigs.isPortrait ?
                          SizeConfigs.screenWidth * 0.25
                          : SizeConfigs.screenWidth * 0.2,
                          // MediaQuery.of(context).size.width * 0.2,
                          height: SizeConfigs.imageSizeMultiplier * 25.0,
                          //  MediaQuery.of(context).size.height * 0.1,
                          child: 
                          // CachedNetworkImage(
                          //   imageUrl: 'http://vod.appcorp.mobi/storage/' +
                          //       widget?.listCast[position]?.image,
                          //   fit: BoxFit.fill,
                          //   placeholder: (context, url) =>
                          //       CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),),
                          //   errorWidget: (context, url, error) =>
                          //       new Icon(Icons.error),
                          // ),
                            Stack(
                            children: [
                                 Positioned(
                                  left: SizeConfigs.screenWidth * 0.10,
                                  top: SizeConfigs.screenWidth * 0.10,
                                  child:  Icon(Icons.error)),
                            Center(
                              child: Container(
                                width: SizeConfigs.imageSizeMultiplier * 45,
                                height: SizeConfigs.screenHeight * 0.25,
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: 'http://vod.appcorp.mobi/storage/' +
                                     widget?.listCast[position]?.image,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(width: 10.0, height: 5.0,),
                      Text(
                        DemoLocalization.of(context).locale.languageCode == 'en' ?
                        widget?.listCast[position].nameEn
                        : widget?.listCast[position].nameAr,
                         style: TextStyle(fontSize: 11),),
                      SizedBox(height: 5.0),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
