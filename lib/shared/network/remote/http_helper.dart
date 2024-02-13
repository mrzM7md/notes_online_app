import 'package:http/http.dart' as http;

const String HTTP_SERVER_LINK = 'http://10.0.2.2/notes_app_api';

const String HTTP_LINK_SIGNUP = '$HTTP_SERVER_LINK/auth/signup.php';
const String HTTP_LINK_LOGIN = '$HTTP_SERVER_LINK/auth/login.php';

Future<http.Response> postRequest({
    required String url,
    required Map<String, String> data
}) async {
  // try{
    // http
    http.Response response = await http.post(
        Uri.parse(url), body: data
    );

    return response;
  //
  // }catch(ex){
  //   return jsonDecode(ex.toString());
  // }
}


Future<http.Response> getRequest({required String url}) async {
    http.Response response = await http.post(
        Uri.parse(url),
    );
    return response;
}

