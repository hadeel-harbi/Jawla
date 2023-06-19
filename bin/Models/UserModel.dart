class UserModel {
  final String name;
  final String email;
  final String phone;
  final String idAuth;
  final String? city;
  final String? profilePic;
  final String? isOwner;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.idAuth,
    this.city,
    this.profilePic,
    this.isOwner,
  });

  factory UserModel.fromJson({required Map json}) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      idAuth: json['id_auth'],
      city: json['city'],
      profilePic: json['profilePic'],
      isOwner: json['is_owner'],
    );
  }

  toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "id_auth": idAuth,
      "city": city,
      "profile_pic": profilePic,
      "is_owner": isOwner,
    };
  }
}
