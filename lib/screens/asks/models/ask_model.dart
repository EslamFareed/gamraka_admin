class AskModel {
  final DateTime createdAt;
  final String question;
  final String answer;
  final User user;
  final String id;

  AskModel({
    required this.createdAt,
    required this.question,
    required this.answer,
    required this.user,
    required this.id,
  });

  factory AskModel.fromJson(Map<String, dynamic> json, String id) {
    return AskModel(
      createdAt: DateTime.parse(json['createdAt']),
      question: json['question'],
      answer: json['answer'],
      user: User.fromJson(json['user']),
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'question': question,
      'answer': answer,
      'user': user.toJson(),
    };
  }
}

class User {
  final String uid;
  final String image;
  final String phone;
  final String name;
  final String idNumber;

  User({
    required this.uid,
    required this.image,
    required this.phone,
    required this.name,
    required this.idNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      image: json['image'],
      phone: json['phone'],
      name: json['name'],
      idNumber: json['idNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'image': image,
      'phone': phone,
      'name': name,
      'idNumber': idNumber,
    };
  }
}
