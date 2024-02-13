import 'package:notes_online_app/models/user_model.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}

//###################### START MODE THEME STATES ######################//
class AppChangeModeState extends AppStates{}
//###################### END MODE THEME STATES ######################//

//###################### START PASSWORD VISIBILITY STATES ######################//
class AuthChangePasswordVisibilityState extends AppStates{}
class AuthChangePasswordConfirmationVisibilityState extends AppStates{}
//###################### END PASSWORD VISIBILITY STATES ######################//

//###################### START SIGNUP STATES ######################//
class AuthLoadingSignupState extends AppStates{}
class AuthSuccessSignupState extends AppStates{
  final User user;
  final String message;
  AuthSuccessSignupState({
    required this.user,
    required this.message,
  });
}
class AuthFailSignupState extends AppStates{
  final String message;
  AuthFailSignupState({
    required this.message,
  });
}
class AuthFailConnectionSignupState extends AppStates{
  final String message;
  AuthFailConnectionSignupState({
    required this.message,
  });
}
//###################### END SIGNUP STATES ######################//


//###################### START LOGIN STATES ######################//
class AuthLoadingLoginState extends AppStates{}
class AuthSuccessLoginState extends AppStates{
  final User user;
  final String message;
  AuthSuccessLoginState({
    required this.user,
    required this.message,
  });
}
class AuthFailLoginState extends AppStates{
  final String message;
  AuthFailLoginState({
    required this.message,
  });
}
class AuthFailConnectionLoginState extends AppStates{
  final String message;
  AuthFailConnectionLoginState({
    required this.message,
  });
}
//###################### END LOGIN STATES ######################//