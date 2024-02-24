import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_online_app/shared/style/colors.dart';

import '../app_organization.dart';

class CustomBuildInput extends StatelessWidget {
  String textTitle;
  TextEditingController controller;
  FocusNode? focusNode;
  TextInputType? inputType;
  String hintInput;
  IconData? prefixInputIcon, suffixInputIcon;
  bool isPrefixIconFromFontAwesome;
  bool isSuffixIconFromFontAwesome;
  String? Function(dynamic) validate;
  Function? onPressedSuffixIcon;
  bool? isVisiblePassword;
  Function(String)? onFieldSubmitted;
  Function(dynamic)? onChange;

  CustomBuildInput(
      {required this.textTitle,
      required this.controller,
      this.focusNode,
      this.inputType,
      required this.hintInput,
      this.prefixInputIcon,
      this.suffixInputIcon,
      this.isPrefixIconFromFontAwesome = false,
      this.isSuffixIconFromFontAwesome = false,
      this.isVisiblePassword = false,
      required this.validate,
      this.onPressedSuffixIcon,
      this.onFieldSubmitted,
      this.onChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = AppOrganization.aoIsDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color:
                isDarkMode ? secondaryDarkModeColor : secondaryLightModeColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: inputType,
          validator: validate,
          obscureText: inputType == TextInputType.visiblePassword
              ? (isVisiblePassword! ? false : true)
              : false,
          style: TextStyle(
            color: isDarkMode ? thirdDarkModeColor : secondaryLightModeColor,
          ),
          onChanged: onChange,
          decoration: InputDecoration(
            // hintText: '',
            labelText: hintInput,
            labelStyle: TextStyle(
              color:
                  isDarkMode ? secondaryDarkModeColor : secondaryLightModeColor,
            ),

            contentPadding:
                const EdgeInsetsDirectional.symmetric(horizontal: 20),
            helperMaxLines: 1,
            prefixIcon: prefixInputIcon != null
                ? Icon(
                    prefixInputIcon,
                    color: isDarkMode
                        ? secondaryDarkModeColor
                        : secondaryLightModeColor,
                    size: isPrefixIconFromFontAwesome ? 20 : null,
                  )
                : null,
            suffixIcon: suffixInputIcon != null
                ? IconButton(
                    icon: Icon(
                      suffixInputIcon,
                      size: isSuffixIconFromFontAwesome ? 20 : null,
                    ),
                    color: isDarkMode
                        ? secondaryDarkModeColor
                        : secondaryLightModeColor,
                    onPressed: () {
                      onPressedSuffixIcon != null
                          ? onPressedSuffixIcon!()
                          : null;
                    },
                  )
                : null,
            border: const OutlineInputBorder(),
          ),
          onFieldSubmitted: (value) {
            onFieldSubmitted != null ? onFieldSubmitted!(value) : print("null");
          },
        )
      ],
    );
  }
}
