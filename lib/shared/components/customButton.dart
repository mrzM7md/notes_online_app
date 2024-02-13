import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/shared/style/sizes.dart';

import '../app_organization.dart';
import '../style/colors.dart';

class CustomButton extends StatelessWidget {
  Function onPressed;
  String text;
  bool isStreachButton;
  bool isSharpButton;
  double fontSize;
  CustomButton({
    required this.onPressed,
    required this.text,
    this.isStreachButton = true,
    this.isSharpButton = false,
    this.fontSize = 14,
    super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = AppOrganization.aoIsDarkMode;
    Sizes values = Sizes(context: context);
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(8),
        width: isStreachButton ? values.SCREEN_WIDTH : null,
        decoration: BoxDecoration(
          color: isDarkMode ? buttonDarkModeColor.withOpacity(0.45) : secondaryLightModeColor,
          borderRadius: !isSharpButton ? BorderRadius.circular(5) : null,
        ),
        child: Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode ? Colors.black : primaryLightModeColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
