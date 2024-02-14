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
import '../../../shared/texts/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    TextEditingController
        usernameController = TextEditingController(),
        passwordController = TextEditingController();

    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if(state is AuthSuccessLoginState){
              getToast(message: state.message,
                  bkgColor: Colors.greenAccent,
                  textColor: Colors.black
              );
              navigateTo(context, NOTES_ROUTE);
            }
            else if(state is AuthFailLoginState){
              getToast(message: state.message,
                  bkgColor: Colors.red,
                  textColor: Colors.white
              );
            }
            else if(state is AuthFailConnectionLoginState){
              getToast(message: state.message,
                  bkgColor: Colors.red,
                  textColor: Colors.white
              );
            }
          },
          builder: (BuildContext context, state) {
            var controller = AppCubit.get(context);
            var formKey = GlobalKey<FormState>();

            return Scaffold(
              body: Container(
                height: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
                color: AppOrganization.aoIsDarkMode ? primaryDarkModeColor : primaryLightModeColor,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        CustomBuildAppbar(
                          clickMode: (){
                            controller.changeAppMode();
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomTitle(title: "$LOGIN $PAGE",), // not add `const`, then will not work !!
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBuildInput(
                          textTitle: "$EMAIL / $USER_NAME",
                          controller: usernameController,
                          focusNode: _emailFocusNode,
                          inputType: TextInputType.emailAddress,
                          hintInput: "$EMAIL / $USER_NAME $IS_REQUIRED",
                          prefixInputIcon: FontAwesomeIcons.at,
                          isPrefixIconFromFontAwesome: true,
                          validate: (value) => getFieldErrorMessage("$value"),
                          onFieldSubmitted: (value) => focusToNode(context, _passwordFocusNode),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBuildInput(
                          textTitle: PASSWORD,
                          controller: passwordController,
                          focusNode: _passwordFocusNode,
                          inputType: TextInputType.visiblePassword,
                          hintInput: "$PASSWORD $IS_REQUIRED",
                          prefixInputIcon: Icons.password_outlined,
                          validate: (value) => getFieldErrorMessage("$value"),
                          suffixInputIcon: controller.isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          isVisiblePassword: controller.isPasswordVisible,
                          onPressedSuffixIcon: (){
                            controller.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is AuthLoadingLoginState,
                          builder: (context) => const Center(child: CircularProgressIndicator()),
                          fallback: (context) =>
                              CustomButton(
                                  onPressed: () {
                                    if (isEveryFieldsValidated(formKey)) {
                                      controller.login(
                                        username: usernameController.text.toString(),
                                        password: passwordController.text.toString(),
                                      );
                                    }
                                  },
                                  text: LOGIN
                              ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        CustomAskToSignUpOrLogin(
                          askWord: "You don't have an account?",
                          answerWord: SIGN_UP,
                          answerClick: () {
                            navigateTo(context, SIGNUP_ROUTE);
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _emailFocusNode.requestFocus());
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
