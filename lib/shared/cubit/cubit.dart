import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_online_app/models/notes_model.dart';
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
  bool _isDarkMode = CacheHelper.getBool(key: 'isDark') ?? false;

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
            Map<String, dynamic> dataResponded = jsonDecode(response.body)['data'];
            emit(AuthSuccessLoginState(
                user: User.login(data: dataResponded),
                message: 'successful login !!'
            ));

            // extract user data after success login !!
            print("Datatype: ${dataResponded['id'] is int}");

            setUserId(dataResponded['id']);
            setUserName(dataResponded['name']);
            setUsername(dataResponded['username']);
            setUserEmail(dataResponded['email']);
            setUserPassword(dataResponded['password']);
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
              message: response.statusCode.toString()
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

  // get user data
  int getUserId() => CacheHelper.getInt(key: 'user_id') ?? -1;
  String getUserName() => CacheHelper.getString(key: 'name') ?? '';
  String getUsername() => CacheHelper.getString(key: 'username') ?? '';
  String getUserEmail() => CacheHelper.getString(key: 'email') ?? '';
  String getUserPassword() => CacheHelper.getString(key: 'password') ?? '';

  // set user data after login
  void setUserId(int id) =>  CacheHelper.setData(key: 'user_id', value: id);
  void setUserName(String name) =>  CacheHelper.setData(key: 'name', value: name);
  void setUsername(String username) =>  CacheHelper.setData(key: 'username', value: username);
  void setUserEmail(String email) =>  CacheHelper.setData(key: 'email', value: email);
  void setUserPassword(String password) =>  CacheHelper.setData(key: 'password', value: password);

  bool isThereUser() => getUserId() != -1;

//###################### END LOGIN PROCESS ######################//



//###################### START GET NOTES PROCESS ######################//
  Future<List?> getAllUserNotes() async {
    int userId = getUserId();
    var response = await getAwaitNotes();

      if(jsonDecode(response.body)['status'] == R_STATUS_SUCCESS){
        List dataResponded = jsonDecode(response.body)['data'];
        print(userId);
        print(dataResponded);
        return dataResponded;
      }
      print("FIELD STATUS: ${jsonDecode(response.body)['status']}, User id= ${getUserId()}");
      return null;
  }

  Future getAwaitNotes() async {
    return await getRequest(url: "$HTTP_LINK_VIEW?user=${getUserId()}");
  }

  Note _currentNote = Note.view(data: { // initiallization..
    "id": -1,
    "title": "",
    "content": "",
    "image": "",
  });

  void setCurrentNote(Note? currentNote, {bool isNewNode = false}) {
    if(!isNewNode) {
      _currentNote = currentNote!;
    } else {
      _currentNote = Note.view(data: { // initiallization..
        "id": -1,
        "title": "",
        "content": "",
        "image": "",
      });
    }
  }
  Note getCurrentNote() => _currentNote;


  /////////// get aet image
  var _image;
  getImage() => _image ?? " ";

  void setImage(Object image){
    _image = image;
    emit(ImageChangedState());
  }

  ///////////// Add Edit Note
  void setNote({required String title, required String content, required int id, String lastImageName=""}){
    emit(AddEditNotesLoadingState());
    Map<String, dynamic> data = {
      "note_id": "$id",
      "note_title": title,
      "note_content": content,
      "user": "${getUserId()}",
      "image": lastImageName,
    };
    var req;
    if(getImage() is File){
      print("Already file exists");
      req = postRequestWithFile(url: id == -1 ? HTTP_LINK_ADD : HTTP_LINK_EDIT, data: data, file: getImage());
    }
    else{
      print("Ther is no File!!!!");
      req = postRequest(url: id == -1 ? HTTP_LINK_ADD : HTTP_LINK_EDIT, data: data);
    }

    req.then((response) {
      if(response.statusCode == 200) {
        if(jsonDecode(response.body)['status'] == R_STATUS_SUCCESS){
          emit(AddEditNotesSuccessState(message: "Successful", data: Note.view(data: data)));
        }
        else if(jsonDecode(response.body)['status'] == "file-fail"){
          emit(AddEditNotesFailState(message: jsonDecode(response.body)['message']));
        }
        else {
          print("Unknown error has been");
          emit(AddEditNotesFailState(message: "Unknown error has been"));
        }
      }
      else {
        throw("Check your internet connection") ;
      }
    }).catchError((error){
      print(error);
      emit(AddEditNotesFailState(message: "$error"));
    });
  }

  /////////// delete Note
  void deleteNote({required int noteId, required String noteImage}){
    getRequest(url: "$HTTP_LINK_DELETE?user=${getUserId()}&note_id=$noteId&note_image=$noteImage").then((response){
      if(response.statusCode == 200) {
        emit(DeleteNotesSuccessState(message: 'Deleted Successful'));
      }
      else {
        throw("Check your internet connection") ;
      }
    } ).catchError((error){
      emit(DeleteNotesFailState(message: "$error"));
    });
    ;
  }

//###################### END GET NOTES PROCESS ######################//

}