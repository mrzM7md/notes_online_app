import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/shared/components/helper_methods.dart';
import 'package:notes_online_app/shared/style/colors.dart';

 AppBar CustomSimpleAppBar({required BuildContext context, required bool isDark, required String title}) => AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: isDark ? secondaryDarkModeColor : secondaryLightModeColor,
        ),
        onPressed: () {
          back(context);
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: isDark ? secondaryDarkModeColor : secondaryLightModeColor
        ),
      ),
      backgroundColor: isDark ? primaryDarkModeColor : primaryLightModeColor,
    );
