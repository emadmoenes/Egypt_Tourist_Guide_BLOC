import 'package:cloud_firestore/cloud_firestore.dart';

class UserFromFirebaseModel {
  final String? email;
  final String? password;


  UserFromFirebaseModel({
    this.email,
    this.password,

  });

  factory UserFromFirebaseModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserFromFirebaseModel(
      email: data?['email'],
      password: data?['password'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (password != null) "password": password,

    };
  }
}