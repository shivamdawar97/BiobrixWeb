import 'package:flutter/material.dart';
import 'package:myapp/utils/screen_type.dart';

class SizingInformation {
  final Orientation orientation;
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    this.orientation,
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize
  });

  @override
  String toString() {
    return 'Orientation: $orientation \n Device: $deviceScreenType\n Screen Size $screenSize \n WidgetSize: $localWidgetSize'; 
  }

}