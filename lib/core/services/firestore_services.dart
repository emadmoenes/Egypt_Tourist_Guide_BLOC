import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> toggleLike(String userId, String placeId) async {

    DocumentReference likeRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('liked_places')
        .doc(placeId);

    DocumentSnapshot doc = await likeRef.get();

    if (doc.exists) {
      // remove the like if the place id already existed for that user
      await likeRef.delete();
    } else {
      // Add the place in the liked places collection
      await likeRef.set({
        'placeId': placeId,
        'likedAt': FieldValue.serverTimestamp(),
      });
    }
  }
}