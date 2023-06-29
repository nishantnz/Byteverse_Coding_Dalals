class UserModel {
  final String name;
  final String userId;
  final String actualId;
  final String phoneNumber;
  final String email;
  final String profilePic;

  UserModel({
    required this.name,
    required this.userId,
    required this.actualId,
    required this.phoneNumber,
    required this.email,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'actualId': actualId,
      'phoneNumber': phoneNumber,
      'email': email,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      userId: map['userId'] as String,
      actualId: map['actualId'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
    );
  }
}
