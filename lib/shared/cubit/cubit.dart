import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_online_app/models/user_model.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/cubit/states.dart';
import 'package:notes_online_app/shared/network/remote/http_helper.dart';
import 'package:notes_online_app/shared/texts/response_status.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


//###################### START THEME PROCESS ######################//
  bool _isDarkMode = CacheHelper.getData(key: 'isDark') ?? false;

  bool getIsDarkMode() => _isDarkMode;

  void changeAppMode() {
    AppOrganization.aoIsDarkMode = _isDarkMode;
    _isDarkMode = !_isDarkMode;
    CacheHelper.setData(key: 'isDark', value: _isDarkMode);
    emit(AppChangeModeState());
  }

//###################### END THEME PROCESS ######################//


//###################### START PASSWORD VISIBILITY PROCESS ######################//
  bool isPasswordVisible = false;
  bool isPasswordConfirmationVisible = false;

  void changePasswordVisibility(){
    isPasswordVisible = !isPasswordVisible;
    emit(AuthChangePasswordVisibilityState());
  }
  void changePasswordConfirmationVisibility(){
    isPasswordConfirmationVisible = !isPasswordConfirmationVisible;
    emit(AuthChangePasswordConfirmationVisibilityState());
  }
//###################### END PASSWORD CONFIRMATION PROCESS ######################//


//###################### START SIGNUP PROCESS ######################//
  void signup({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingSignupState());

    var data = {
      'name' : name,
      'username' : username,
      'email' : email,
      'password' : password,
    };

    await postRequest(url: HTTP_LINK_SIGNUP, data: data)
        .then((response) {
      try {
        if(response.statusCode == 200) {
          if(jsonDecode(response.body)['status'] == R_STATUS_SUCCESS){
            emit(AuthSuccessSignupState(
                user: User.signup(data: data),
                message: 'Signup has been successful !!'
            ));
          }
          else if(jsonDecode(response.body)['status'] == R_STATUS_FAIL){
            emit(AuthFailSignupState(
                message: 'email or username already used !!'
            ));
          }
        }
        else if(response.statusCode == 404 || response.statusCode == 502){
          emit(AuthFailConnectionSignupState(
              message: 'Unknown error, try again later !'
          ));
        }
        else {
          emit(AuthFailConnectionSignupState(
              message: jsonDecode(response.body).toString()
          ));
        }
      }catch(ex){
        emit(AuthFailSignupState(
            message: 'email or username already used !!'
        ));
      }
    })
        .catchError((error){
          emit(AuthFailConnectionSignupState(
              message: error.toString()
          ));
    })
    ;
  }

//###################### END SIGNUP PROCESS ######################//

//###################### START LOGIN PROCESS ######################//
  void login({
    required String username,
    required String password,
  }) async {
    emit(AuthLoadingLoginState());

    var data = {
      'username' : username,
      'password' : password,
    };

    postRequest(url: HTTP_LINK_LOGIN, data: data)
        .then((response) {
      try {
        if(response.statusCode == 200) {
          if(jsonDecode(response.body)['status'] == R_STATUS_SUCCESS){
            emit(AuthSuccessLoginState(
                user: User.signup(data: data),
                message: 'successful login !!'
            ));
          }
          else if(jsonDecode(response.body)['status'] == R_STATUS_FAIL){
            emit(AuthFailLoginState(
                message: 'wrong info !!'
            ));
          }
        }
        else if(response.statusCode == 404 || response.statusCode == 502){
          emit(AuthFailConnectionLoginState(
              message: 'Unknown error, please try again later !'
          ));
        }
        else {
          emit(AuthFailConnectionLoginState(
              message: 'check your connection !'
          ));
        }
      }catch(ex){
        emit(AuthFailLoginState(
            message: 'wrong info !!'
        ));
      }
    })

        .catchError((error){
      emit(AuthFailConnectionSignupState(
          message: error.toString()
      ));
    })
    ;
  }

//###################### END LOGIN PROCESS ######################//

}