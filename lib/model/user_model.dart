class UserModel {
  String name;
  String email;
  String phone;
  String? uid;
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    this.uid,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "phone": phone, "uid": uid};
  }

  static UserModel fromJson(Map<String, dynamic> Json) {
    return UserModel(
      email: Json['email'],
      name: Json['name'],
      phone: Json['phone'],
      uid: Json['uid'],
    );
  }
}
