import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/shared/style/colors.dart';

import '../app_organization.dart';

class CustomTitle extends StatelessWidget {
  String title;
  CustomTitle({
    required this.title,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = AppOrganization.aoIsDarkMode;
    return Text(title,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: isDarkMode ? secondaryDarkModeColor : secondaryLightModeColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.0
      ),
    );
  }
}
