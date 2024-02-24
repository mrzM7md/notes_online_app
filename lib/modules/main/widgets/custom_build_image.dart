import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/network/remote/http_helper.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/style/images.dart';
import 'package:notes_online_app/shared/style/sizes.dart';

class CustomBuildImage extends StatelessWidget {
  Function onTap;
  var image;
  bool isDark = AppOrganization.aoIsDarkMode;

  CustomBuildImage({required this.onTap, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context: context);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
         Material(
           color: isDark ? primaryDarkModeColor : primaryLightModeColor,
           elevation: 2,
           borderRadius:BorderRadius.circular(10) ,
           child: SizedBox(
             height: sizes.SCREEN_WIDTH - 40,
             width: sizes.SCREEN_WIDTH,
             child: image is String ? (image.trim().isEmpty
                 ?
             Image.asset(isDark ? app_logo_dark : app_logo_light, fit: BoxFit.contain)
                 :
             Image.network(HTTP_LINK_IMAGE + image, fit: BoxFit.contain))
                 :
             Image.file(image, fit: BoxFit.contain,),
           ),
         ),
        InkWell(
          onTap: (){
            onTap();
          },
          child: Container(
            margin: const EdgeInsetsDirectional.all(10),
            child: Material(
              color: isDark ? secondaryDarkModeColor : primaryLightModeColor,
              elevation: 10,
              borderRadius:BorderRadius.circular(10) ,
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: Icon(Icons.image,
                  color: isDark ? primaryDarkModeColor : secondaryLightModeColor,
                ),),
              ),
            ),
        ),
      ],
    );
  }
}
