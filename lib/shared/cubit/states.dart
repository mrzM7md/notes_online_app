import 'package:notes_online_app/models/notes_model.dart';
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

//###################### START NOTES STATES ######################//
class ViewNotesState extends AppStates{
  final String message;
  final Note data;
  ViewNotesState({
    required this.message,
    required this.data
  });
}

class ImageChangedState extends AppStates{}
//###################### END NOTES STATES ######################//

//###################### START ADD-EDIT NOTE STATE ######################//
class AddEditNotesSuccessState extends AppStates{
  final String message;
  final Note data;
  AddEditNotesSuccessState({
    required this.message,
    required this.data
  });
}

class AddEditNotesFailState extends AppStates{
  final String message;
  AddEditNotesFailState({
    required this.message,
  });
}

class AddEditNotesLoadingState extends AppStates{}
//###################### END ADD-EDIT NOTE STATE ######################//

//###################### START DELETE NOTE STATE ######################//
class DeleteNotesSuccessState extends AppStates{
  final String message;
  DeleteNotesSuccessState({
    required this.message,
  });
}
class DeleteNotesFailState extends AppStates{
  final String message;
  DeleteNotesFailState({
    required this.message,
  });
}
//###################### END DELETE NOTE STATE ######################//
