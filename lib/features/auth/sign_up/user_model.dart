class UserModel {
  final String name;
  final String phone;
  final String bio;

  UserModel({
    required this.name,
    required this.phone,
    required this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'], phone: json['phone'], bio: json['bio']);
  }

  Map<String , dynamic> toJson(){
    return {
      'name':name,
      'phone':phone,
      'bio':bio
    };
  }
}
