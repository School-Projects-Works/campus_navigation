import 'package:campus_navigation/features/emergency/data/emergency_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyServices{
  static final  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _emergenciesCollection = _firestore.collection('emergencies');

static String getNewId() {
    return _emergenciesCollection.doc().id;
  }
  static Future<bool> addEmergency(EmergencyModel emergency) async {
    try {
      await _emergenciesCollection.doc(emergency.id).set(emergency.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateEmergency(String id, Map<String, dynamic> emergency) async {
    try {
      await _emergenciesCollection.doc(id).update(emergency);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteEmergency(String id) async {
    try {
      await _emergenciesCollection.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<List<EmergencyModel>> getEmergencies() {
    return _emergenciesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EmergencyModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}