import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../texts/errors_messages.dart';


bool isTextEmpty(String value){
  if (value.isEmpty) {
    return true;
  }
  return false;
}

String? getFieldErrorMessage(String value, {String? message}){
  if (isTextEmpty(value)) {
    return message ?? FILL_FIELD_MESSAGE_ERROR;
  }
  return null;
}


bool isPasswordAndConfirmPasswordAreEqual({required String password, required String confirmationPassword}){
  return password == confirmationPassword;
}

bool isEveryFieldsValidated(GlobalKey<FormState> formKey)
   => formKey.currentState!.validate();

void navigateTo(fromWidgetContext, toRoute) =>
    Navigator.pushNamed(
        fromWidgetContext, toRoute
    );

void back(context) =>
    Navigator.pop(
        context
    );

void focusToNode(BuildContext context, FocusNode destinationNode)
    => FocusScope.of(context).requestFocus(destinationNode);

void getToast({
  required String message,
  required Color bkgColor,
  required Color textColor,
}){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT, // seconds for android.. // 5 seconds for LONG, 1 for SHORT
    gravity: ToastGravity.BOTTOM,
// timeInSecForIosWeb: 1, // seconds for web
    backgroundColor: bkgColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}