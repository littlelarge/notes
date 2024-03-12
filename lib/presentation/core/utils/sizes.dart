import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sizes {
  static final appBarHeight = 60.r;

  static double getScreenSizeWithoutAppBarHeight({required double value}) =>
      clampDouble(value, 0, 1).sh - appBarHeight;
}
