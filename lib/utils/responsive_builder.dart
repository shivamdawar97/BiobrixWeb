import 'package:flutter/material.dart';
import 'package:myapp/utils/size_info.dart';
import 'package:myapp/utils/ui_utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context,SizingInformation sizingInformation) builder;
  const ResponsiveBuilder({Key key,this.builder}):super(key:key);

@override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(builder: (context,constraints){
      var sizingInformation = SizingInformation(
      orientation: mediaQuery.orientation,
      deviceScreenType: getDeviceScreenType(mediaQuery),
      screenSize: mediaQuery.size,
      localWidgetSize: Size(constraints.maxWidth,constraints.maxHeight)
    );
        return builder(context,sizingInformation);
    });
  }

}