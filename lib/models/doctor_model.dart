class DoctorModel {
  final String name;
  final String userId;
  final String actualId;
  final String phoneNumber;
  final String email;
  final String profilePic;
  final String expertise;
  final String address;
  DoctorModel({
    required this.name,
    required this.userId,
    required this.actualId,
    required this.phoneNumber,
    required this.email,
    required this.profilePic,
    required this.expertise,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'actualId': actualId,
      'phoneNumber': phoneNumber,
      'email': email,
      'profilePic': profilePic,
      'expertise': expertise,
      'address': address,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      name: map['name'] as String,
      userId: map['userId'] as String,
      actualId: map['actualId'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      expertise: map['expertise'] as String,
      address: map['address'] as String,
    );
  }
}
