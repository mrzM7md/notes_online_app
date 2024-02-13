import 'package:flutter/cupertino.dart';
import 'package:notes_online_app/shared/components/customButton.dart';

import '../app_organization.dart';
import '../style/colors.dart';

class CustomAskToSignUpOrLogin extends StatelessWidget {
  String askWord, answerWord;
  Function answerClick;

  CustomAskToSignUpOrLogin({
    required this.askWord,
    required this.answerWord,
    required this.answerClick,
    super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = AppOrganization.aoIsDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          askWord,
          style: TextStyle(
              color: isDarkMode ? buttonDarkModeColor : secondaryLightModeColor,
              fontSize: 12
          ),
        ),
        const SizedBox(width: 10),
        CustomButton(onPressed: (){
          answerClick();
        },
            text: answerWord,
            isSharpButton: true,
            isStreachButton: false,
          fontSize: 10,
        )
      ],
    );
  }
}
