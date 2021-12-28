class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? secondname;
  String? username;

  UserModel(
      {this.uid, this.email, this.firstname, this.secondname, this.username});

  // receiving data from server

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstname'],
      secondname: map['lastname'],
      username: map['username'],
    );
  }

  //sending data to our server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'secondname': secondname,
      'username': username,
    };
  }
}
