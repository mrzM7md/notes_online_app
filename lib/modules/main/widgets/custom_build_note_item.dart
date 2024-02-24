import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/models/notes_model.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/network/remote/http_helper.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/style/images.dart';

class CustomBuildNoteItem extends StatelessWidget {
  Note note;
  Function onTap;
  CustomBuildNoteItem({
    required this.note,
    required this.onTap,
    super.key
  }); // not convert to const for theme

  @override
  Widget build(BuildContext context) {
    bool isDark = AppOrganization.aoIsDarkMode;
    return InkWell(
      child: Card(
        color: isDark ? buttonDarkModeColor : primaryLightModeColor,
        elevation: 5.0,
        margin: const EdgeInsetsDirectional.all(0.0),
        child: ListTile(
            leading: Card(
              color: isDark ? primaryDarkModeColor : primaryLightModeColor,
              elevation: 5.0,
              margin: const EdgeInsetsDirectional.all(0.0),
              child: note.image!.trim().isEmpty
                  ? Image.asset(isDark ? app_logo_dark : app_logo_light, height: 60, width: 60,)
                  :
                  Image.network(HTTP_LINK_IMAGE + note.image!, height: 60, width: 60,),
        ),
          title: Text(note.title!),
          subtitle: Text(note.content!),
        ),
      ),
      onTap: (){
        onTap();
      },
    );
  }
}
