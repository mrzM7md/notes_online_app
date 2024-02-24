import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;

// const String HTTP_SERVER_LINK = 'https://notes-online-api.mrzsw.com';
const String HTTP_SERVER_LINK = 'http://10.0.2.2/notes_app_api';

const String HTTP_LINK_SIGNUP = '$HTTP_SERVER_LINK/auth/signup.php';
const String HTTP_LINK_LOGIN = '$HTTP_SERVER_LINK/auth/login.php';
const String HTTP_LINK_ADD = '$HTTP_SERVER_LINK/notes/add.php';
const String HTTP_LINK_EDIT = '$HTTP_SERVER_LINK/notes/edit.php';
const String HTTP_LINK_DELETE = '$HTTP_SERVER_LINK/notes/delete.php';
const String HTTP_LINK_VIEW = '$HTTP_SERVER_LINK/notes/view.php';
const String HTTP_LINK_IMAGE = '$HTTP_SERVER_LINK/assets/images/';

Future<http.Response> postRequest({
    required String url,
    required Map<String, dynamic> data
}) async {
     return await http.post(
        Uri.parse(url), body: data
     );
}


Future<http.Response> getRequest({required String url}) async {
    http.Response response = await http.get(
        Uri.parse(url),
    );
    return response;
}

Future<http.Response> postRequestWithFile({required String url,required Map data, required File file}
    ) async {
  var request = http.MultipartRequest("POST", Uri.parse(url));
  var length = await file.length();
  var stream = http.ByteStream(file.openRead());
  var multipartFile = http.MultipartFile("note_image", stream, length,
      filename: basename(file.path));
  request.files.add(multipartFile);
  data.forEach((key, value) {
    request.fields[key] = value;
  });
  var myRequest = await request.send();

  var response = await http.Response.fromStream(myRequest);

  return response;
}

