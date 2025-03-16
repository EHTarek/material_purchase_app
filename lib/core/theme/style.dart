
import 'package:material_purchase_app/app_config.dart';
import 'package:flutter/material.dart';

final fontRegular = TextStyle(
  fontFamily: AppConfig.fontFamily,
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final fontMedium = TextStyle(
  fontFamily: AppConfig.fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

final fontBold = TextStyle(
  fontFamily: AppConfig.fontFamily,
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final fontExtraBold = TextStyle(
  fontFamily: AppConfig.fontFamily,
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
);


class Dimensions {
  static double fontSizeOverSmall = 8.0;
  static double fontSizeExtraSmall = 10.0;
  static double fontSizeSmall = 12.0;
  static double fontSizeDefault = 14.0;
  static double fontSizeLarge = 16.0;
  static double fontSizeExtraLarge = 18.0;
  static double fontSizeOverLarge = 24.0;

  static const double paddingSizeExtraSmall = 5.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeDefault = 15.0;
  static const double paddingSizeLarge = 20.0;
  static const double paddingSizeExtraLarge = 25.0;
  static const double paddingSizeExtremeLarge = 30.0;
  static const double paddingSizeExtraOverLarge = 35.0;

  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static const double radiusExtraLarge = 20.0;
  static const double radiusOverLarge = 30.0;

  static const double webMaxWidth = 1170;
  static const int messageInputLength = 1000;
}
