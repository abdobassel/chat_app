class UserModel {
  final String token;
  final String name;
  final String email;

  UserModel({
    required this.token,
    required this.name,
    required this.email,
  });

  get uId => null;

  // دالة لتحويل بيانات المستخدم إلى صيغة Map لتخزينها في فايرستور
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
      'email': email,
    };
  }

  // دالة لإنشاء نموذج المستخدم من Map (عند استرجاع البيانات من فايرستور)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
