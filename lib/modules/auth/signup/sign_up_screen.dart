import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_online_app/shared/components/custom_build_appbar.dart';
import 'package:notes_online_app/shared/components/customButton.dart';
import 'package:notes_online_app/shared/components/custom_build_input.dart';
import 'package:notes_online_app/shared/components/custom_title.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/texts/fields_names.dart';

import '../../../shared/app_organization.dart';
import '../../../shared/components/custom_ask_to_sign_up_or_login.dart';
import '../../../shared/components/helper_methods.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';
import '../../../shared/texts/errors_messages.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(),
        usernameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController(),
        confirmPasswordController = TextEditingController();

    FocusNode? usernameFocusNode = FocusNode(),
        emailFocusNode = FocusNode(),
        passwordFocusNode = FocusNode(),
        confirmPasswordFocusNode = FocusNode();

    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if(state is AuthSuccessSignupState){
              getToast(message: state.message,
                  bkgColor: Colors.greenAccent,
                  textColor: Colors.black
              );
            }
            else if(state is AuthFailSignupState){
                getToast(message: state.message,
                    bkgColor: Colors.red,
                    textColor: Colors.white
                );
              }
            else if(state is AuthFailConnectionSignupState){
              getToast(message: state.message,
                  bkgColor: Colors.red,
                  textColor: Colors.white
              );
            }
          },
          builder: (BuildContext context, state) {
            var backend = AppCubit.get(context);
            var formKey = GlobalKey<FormState>();

            return Scaffold(
              body: Container(
                height: double.infinity,
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
                color: AppOrganization.aoIsDarkMode
                    ? primaryDarkModeColor
                    : primaryLightModeColor,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        CustomBuildAppbar(
                          clickMode: () {
                            backend.changeAppMode();
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomTitle(
                          title: "$SIGN_UP $PAGE",
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        // not add `const`, then will not work !!
                        CustomBuildInput(
                          textTitle: YOUR_NAME,
                          controller: nameController,
                          inputType: TextInputType.name,
                          hintInput: "$YOUR_NAME $IS_REQUIRED",
                          prefixInputIcon: Icons.person_2_outlined,
                          validate: (value) => getFieldErrorMessage("$value"),
                          onFieldSubmitted: (value) => focusToNode(context, usernameFocusNode),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBuildInput(
                          textTitle: USER_NAME,
                          controller: usernameController,
                          focusNode: usernameFocusNode,
                          inputType: TextInputType.name,
                          hintInput: "$USER_NAME $IS_REQUIRED",
                          prefixInputIcon: FontAwesomeIcons.at,
                          isPrefixIconFromFontAwesome: true,
                          validate: (value) => getFieldErrorMessage("$value"),
                          onFieldSubmitted: (value) => focusToNode(context, emailFocusNode),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBuildInput(
                          textTitle: EMAIL,
                          controller: emailController,
                          focusNode: emailFocusNode,
                          inputType: TextInputType.emailAddress,
                          hintInput: "$EMAIL $IS_REQUIRED",
                          prefixInputIcon: Icons.email_outlined,
                          validate: (value) => getFieldErrorMessage("$value"),
                          onFieldSubmitted: (value) => focusToNode(context, passwordFocusNode),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBuildInput(
                          textTitle: PASSWORD,
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          inputType: TextInputType.visiblePassword,
                          hintInput: "$PASSWORD $IS_REQUIRED",
                          prefixInputIcon: Icons.password_outlined,
                          validate: (value) => getFieldErrorMessage("$value"),
                          suffixInputIcon: backend.isPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          isVisiblePassword: backend.isPasswordVisible,
                          onPressedSuffixIcon: () =>backend.changePasswordVisibility(),
                          onFieldSubmitted: (value) => focusToNode(context, confirmPasswordFocusNode),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBuildInput(
                          textTitle: CONFIRM_PASSWORD,
                          controller: confirmPasswordController,
                          focusNode: confirmPasswordFocusNode,
                          inputType: TextInputType.visiblePassword,
                          hintInput: "$CONFIRM_PASSWORD $IS_REQUIRED",
                          prefixInputIcon: Icons.password_outlined,
                          validate: (value) {
                            if(!isTextEmpty(value)){
                              if(isPasswordAndConfirmPasswordAreEqual(password: passwordController.text, confirmationPassword: confirmPasswordController.text)){
                                return null;
                              }
                              return 'password are not same !';
                            }
                            return getFieldErrorMessage(value);
                          },
                          suffixInputIcon: backend.isPasswordConfirmationVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          isVisiblePassword:
                              backend.isPasswordConfirmationVisible,
                          onPressedSuffixIcon: () => backend.changePasswordConfirmationVisibility(),
                        ),
                        const SizedBox(
                          height: 40,
                        ),

                        ConditionalBuilder(
                            condition: state is AuthLoadingSignupState,
                            builder: (context) => const Center(child: CircularProgressIndicator()),
                            fallback: (context) =>
                                CustomButton(
                                  onPressed: () {
                                    if (isEveryFieldsValidated(formKey)) {
                                      backend.signup(
                                          name: nameController.text.toString(),
                                          username: usernameController.text.toString(),
                                          email: emailController.text.toString(),
                                          password: passwordController.text.toString()
                                      );
                                    }
                                  },
                                  text: SIGN_UP
                            ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomAskToSignUpOrLogin(
                          askWord: "already You have an account?",
                          answerWord: LOGIN,
                          answerClick: () {
                            back(context);
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
