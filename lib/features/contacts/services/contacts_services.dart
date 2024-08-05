import 'package:campus_navigation/features/contacts/data/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _contactsCollection = _firestore.collection('contacts');

  static String getNewId() {
    return _contactsCollection.doc().id;
  }
  static Future<bool> addContact(ContactModel contact) async {
    try {
      await _contactsCollection.doc(contact.id).set(contact.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateContact(String id, Map<String, dynamic> contact) async {
    try {
      await _contactsCollection.doc(id).update(contact);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteContact(String id) async {
    try {
      await _contactsCollection.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<List<ContactModel>> getContacts() {
    return _contactsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ContactModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}