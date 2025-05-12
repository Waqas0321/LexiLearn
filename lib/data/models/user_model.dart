class UserModel {
  String firstName;
  String? userID;
  String lastName;
  String email;

  UserModel({
    required this.firstName,
    this.userID,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      userID: json['userId'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'userId': userID,
      'lastName': lastName,
      'email': email,
    };
  }
}
