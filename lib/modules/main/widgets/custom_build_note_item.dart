import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/style/images.dart';

class CustomBuildNoteItem extends StatelessWidget {
  const CustomBuildNoteItem({super.key}); // not convert to const for theme

  @override
  Widget build(BuildContext context) {
    bool isDark = AppOrganization.aoIsDarkMode;
    return Card(
      color: isDark ? buttonDarkModeColor : primaryLightModeColor,
      elevation: 5.0,
      margin: const EdgeInsetsDirectional.all(0.0),
      child: ListTile(
          leading: Card(
            elevation: 5.0,
            margin: const EdgeInsetsDirectional.all(0.0),
            child: Image.asset(app_logo_light, height: 60, width: 60,),
          ),
        title: const Text("Title"),
        subtitle: const Text("This is descriptoin"),
      ),
    );
  }
}
