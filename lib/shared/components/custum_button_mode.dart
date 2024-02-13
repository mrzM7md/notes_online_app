import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/style/images.dart';
import 'package:notes_online_app/shared/style/sizes.dart';

import '../app_organization.dart';

class CustomButtonMode extends StatelessWidget {
  final Function function;
  CustomButtonMode({
    required this.function,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var values = Sizes(context: context);
    bool isDarkMode = AppOrganization.aoIsDarkMode;

    double logoWidth = values.SCREEN_WIDTH * 0.20 / 2;
    double logoHeight = logoWidth;

    return InkWell(
      onTap: (){
        function();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: isDarkMode ? primaryLightModeColor : primaryDarkModeColor,
              width: 1.2
          ),
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
        ),
        child: Image.asset(
          isDarkMode ? mode_image_dark : mode_image_light,
          height: logoHeight,
          width: logoWidth,
        ),
      ),
    );
  }
}
