import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egypt_tourist_guide/models/governorate_model.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:egypt_tourist_guide/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  //------- Firebase auth feature ------//
  static FirebaseAuth authInstance = FirebaseAuth.instance;

  //--- Sign in with email and password method ---//
  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credentials = await authInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  //--- Create user with email and password ---//
  static Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final credential = await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // Log out from firebase auth
  static Future<void> signOut() async => await authInstance.signOut();

  /////////////////////////////////////////////////
  //----- Firebase firestore feature -----//

  // database instance
  static FirebaseFirestore db = FirebaseFirestore.instance;

  // create a collection called users
  static CollectionReference users = db.collection('users');

  // Add user document to the collection users in database after sign up
  static Future<void> addUser({
    required UserModel user,
  }) {
    // Call the user's CollectionReference to add a new user
    return users.add(user.toMap());
  }

  // create a collection called governorates
  // static CollectionReference governorates = db.collection('governorates');

  //--- Get english governorates method ---//
  static Future<List<GovernorateModel>> getGovernorates() async {
    List<GovernorateModel> governorates = [];
    await db.collection("governorates").get().then((event) {
      for (var doc in event.docs) {
        governorates.add(GovernorateModel.fromFirestore(doc));
      }
    });
    return governorates;
  }

  //--- Get arabic governorates method ---//
  static Future<List<GovernorateModel>> getArabicGovernorates() async {
    List<GovernorateModel> arabicGovernorates = [];
    await db.collection("arabic_governorates").get().then((event) {
      for (var doc in event.docs) {
        arabicGovernorates.add(GovernorateModel.fromFirestore(doc));
      }
    });
    return arabicGovernorates;
  }

  static Future<List<int>> getUserFavouritePlacesId(
      {required String uid, required bool isEnglish}) async {
    final snapshot = await users.where('uid', isEqualTo: uid).get();

    // Extract the likedPlaces array from the document
    List<dynamic> favPlacesDynamic = snapshot.docs.first['favPlaces'];

    // Convert the dynamic list to a List<int>
    return favPlacesDynamic.map((item) => item as int).toList();
  }

  static saveUserDataInSignUp(
      {required String uid, required String name}) async {
    await users.add({'uid': uid, 'name': name, 'favPlaces': []});
  }

  static Future<PlacesModel> getPlaceById(
      {required int id, required bool isEnglish}) async {
    final snapshot = await db
        .collection(isEnglish ? 'places' : 'arabic_places')
        .where('id', isEqualTo: id)
        .get();
    return PlacesModel.fromMap(snapshot.docs.first.data());
  }
}
