import 'dart:typed_data';

import 'package:campus_navigation/features/home/data/place_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PlacesServices{
  static final CollectionReference placesCollection = FirebaseFirestore.instance.collection('places');
  final FirebaseStorage storage = FirebaseStorage.instance;


  static String getPlaceId(){
    return placesCollection.doc().id;
  }

  static Future<bool>  savePlace(PlaceItem placeItem) async {
    try {
      await placesCollection.doc(placeItem.id).set(placeItem.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<List<PlaceItem >> getPlaces() {
    return placesCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => PlaceItem.fromMap(doc.data() as Map<String,dynamic>)).toList());
  }

  static Future<bool>deletePlace(String id)async {
    try {
      await placesCollection.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> uploadImage(Uint8List image) async{
      var ref = FirebaseStorage.instance.ref().child('places/${DateTime.now().millisecondsSinceEpoch}');
      await ref.putData(image, SettableMetadata(contentType: 'image/jpeg'));
      var url =await ref.getDownloadURL();
    
    return url;
  }


}