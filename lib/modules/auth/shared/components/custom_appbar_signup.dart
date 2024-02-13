import 'package:flutter/cupertino.dart';
import 'package:notes_online_app/shared/components/app_logo_image.dart';
import 'package:notes_online_app/shared/components/custum_button_mode.dart';

class CustomAppbarAuth extends StatelessWidget {
  Function clickMode;
  CustomAppbarAuth({
    required this.clickMode,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppLogoImage(),
        const Spacer(),
        CustomButtonMode(
            function: (){
              clickMode();
            }
        )
      ],
    );
  }
}
