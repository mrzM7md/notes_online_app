import 'package:flutter/cupertino.dart';
import 'package:notes_online_app/shared/style/images.dart';
import 'package:notes_online_app/shared/style/sizes.dart';

import '../app_organization.dart';

class AppLogoImage extends StatelessWidget {
  AppLogoImage({
    super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = AppOrganization.aoIsDarkMode;
    Sizes values = Sizes(context: context);
    double logoWidth = values.QUARTER_SCREEN_WIDTH;
    double logoHeight = logoWidth / 2;

    return Image.asset(isDarkMode ? app_logo_dark : app_logo_light,
      height: logoHeight, width: logoWidth,);
  }
}