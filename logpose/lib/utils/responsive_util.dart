import 'package:flutter/cupertino.dart';

class ResponsiveUtil {
  const ResponsiveUtil();

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 600 &&
        MediaQuery.sizeOf(context).width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 1200;
  }
}
