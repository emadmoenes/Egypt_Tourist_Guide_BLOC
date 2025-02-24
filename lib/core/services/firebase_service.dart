import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/governorate_model.dart';

class FirebaseService {
  //------- Firebase auth feature ------//
  static FirebaseAuth authInstance = FirebaseAuth.instance;

  // sign in with email and password
  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credentials = await authInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  // create user with email and password
  static Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final credential = await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // log out from firebase auth
  static Future<void> signOut() async => await authInstance.signOut();

/////////////////////////////////////////////////
  //----- Firebase firestore feature -----//

  // database instance
  static FirebaseFirestore db = FirebaseFirestore.instance;

  // Create a collection called governorates
  static CollectionReference<Map<String, dynamic>> governoratesCollection =
      db.collection('governorates');

  //----- Get english governorates method -----//
  static Future<List<GovernorateModel>> getGovernorates() async {
    List<GovernorateModel> governorates = [];
    await governoratesCollection.get().then((event) {
      for (var doc in event.docs) {
        governorates.add(GovernorateModel.fromFirestore(doc));
      }
    });
    return governorates;
  }

  // Create a collection called arabic governorates
  static CollectionReference<Map<String, dynamic>> governoratesACollection =
      db.collection('arabic_governorates');

  //----- Get arabic governorates method -----//
  static Future<List<GovernorateModel>> getArabicGovernorates() async {
    List<GovernorateModel> arabicGovernorates = [];
    await governoratesACollection.get().then((event) {
      for (var doc in event.docs) {
        arabicGovernorates.add(GovernorateModel.fromFirestore(doc));
      }
    });
    return arabicGovernorates;
  }
}
