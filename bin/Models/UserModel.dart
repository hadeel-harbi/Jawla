class UserModel {
  final String name;
  final String email;
  final String phone;
  final String idAuth;
  final String? location;
  final String? profilePic;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.idAuth,
    this.location,
    this.profilePic,
  });

  factory UserModel.fromJson({required Map json}) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      idAuth: json['id_auth'],
      location: json['location'],
      profilePic: json['profilePic'],
    );
  }

  toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "id_auth": idAuth,
      "location": location,
      "profile_pic": profilePic,
    };
  }
}
