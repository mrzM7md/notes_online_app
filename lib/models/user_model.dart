class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? password;

  User.signup({required Map<String, dynamic> data}){
    id = (data['id'] ?? -1) as int?;
    name = data['name'];
    username = data['username'];
    email = data['email'];
    password = data['password'];
  }

  User.login({required Map<String, dynamic> data}){
    id = data['id'] as int?;
    username = data['username'];
    password = data['password'];
  }
}