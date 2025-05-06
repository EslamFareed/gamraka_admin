class UserModel {
  final String id;
  final String password;
  final String phone;
  final String name;
  final String idNumber;
  final String image;

  UserModel({
    required this.id,
    required this.password,
    required this.phone,
    required this.name,
    required this.idNumber,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      password: json['password'],
      phone: json['phone'],
      name: json['name'],
      idNumber: json['idNumber'],
      image: json['image'],
    );
  }
}
