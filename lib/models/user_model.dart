class User {
  String fullName;
  String email;
  String password;
  String? phoneNumber;
  String? profilePicUrl;
  String? address;

  User({
    required this.fullName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.profilePicUrl,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      profilePicUrl: map['profilePicUrl'],
    );
  }
}
