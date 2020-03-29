import 'package:flutter/cupertino.dart';
import 'package:myapp/utils/screen_type.dart';

DeviceScreenType getDeviceScreenType(MediaQueryData mediaQuery){
  double deviceWidth = mediaQuery.orientation == Orientation.portrait? mediaQuery.size.width : mediaQuery.size.longestSide;

  if(deviceWidth > 990) return DeviceScreenType.Desktop;
  if(deviceWidth > 600) return DeviceScreenType.Tablet;
  return DeviceScreenType.Mobile;
}