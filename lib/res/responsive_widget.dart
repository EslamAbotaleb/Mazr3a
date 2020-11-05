
import 'package:flutter/material.dart';
import 'package:primaxproject/res/sizeconfig.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget portraitLayout;
  final Widget landscapeLayout;

  const ResponsiveWidget({
    Key key,
    @required this.portraitLayout,
    this.landscapeLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SizeConfigs.isPortrait && SizeConfigs.isMobilePortrait) {
      return portraitLayout;
    } else {
      return landscapeLayout ?? portraitLayout;
    }
  }
}