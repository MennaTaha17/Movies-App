class UserModel {
  String name;
  String email;
  String phone;
  String? uid;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.uid,
  });

  /// تحويل البيانات إلى Map لحفظها في Firestore
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uid": uid,
    };
  }

  /// إنشاء UserModel من Map تم جلبها من Firestore
  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      uid: json['uid'],
    );
  }
}
