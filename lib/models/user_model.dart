class User {
  String? name;
  String? username;
  String? email;
  String? password;

  User.signup({required Map<String, String> data}){
    name = data['name'];
    username = data['username'];
    email = data['email'];
    password = data['password'];
  }

  User.login({required Map<String, String> data}){
    username = data['username'];
    password = data['password'];
  }

}