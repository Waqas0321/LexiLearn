class UserModel {
  String firstName;
  String? userID;
  String lastName;
  String email;
  String? imagePath;

  UserModel({
    required this.firstName,
    this.userID,
    required this.lastName,
    required this.email,
    this.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      userID: json['userId'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'userId': userID,
      'lastName': lastName,
      'email': email,
      'imagePath': imagePath,
    };
  }
}
