import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egypt_tourist_guide/models/governorate_model.dart';

class GovernoratesService {
  var db = FirebaseFirestore.instance;

  Future<List<GovernorateModel>> getGovernorates() async {
    List<GovernorateModel> governorates = [];
    await db.collection("governorates").get().then((event) {
      for (var doc in event.docs) {
        governorates.add(GovernorateModel.fromFirestore(doc));
      }
    });
    return governorates;
  }

  Future<List<GovernorateModel>> getArabicGovernorates() async {
    List<GovernorateModel> arabicGovernorates = [];
    await db.collection("arabic_governorates").get().then((event) {
      for (var doc in event.docs) {
        arabicGovernorates.add(GovernorateModel.fromFirestore(doc));
      }
    });
    return arabicGovernorates;
  }
}
