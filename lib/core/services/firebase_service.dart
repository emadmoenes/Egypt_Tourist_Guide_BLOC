import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egypt_tourist_guide/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  static final String _usersCollection = 'users';

  // create a collection called users
  static CollectionReference users = db.collection('users');

  // Add user document to the collection users in database after sign up
  static Future<void> addUser({
    required UserModel user,
  }) {
    // Call the user's CollectionReference to add a new user
    return users.add(user.toMap());
  }

  static saveUserDataInSignUp({required String uid, required String name})async{
    await db.collection(_usersCollection).add(
      {
        'uid': uid,
        'name': name,
        'favPlaces': []
      }
    );
  }
}
