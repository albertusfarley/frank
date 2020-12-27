import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frank/models/data.dart';

class AccountService {
  final String uid;
  AccountService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Data _generateData(DocumentSnapshot doc) {
    return Data(role: doc.data()['role']);
  }

  Stream<Data> get myData {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(_generateData);
  }

  Future<bool> isKnown() async {
    bool exists = false;
    try {
      await userCollection.doc(uid).get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<int> getUserRole() async {
    int role = -100;

    try {
      await userCollection.doc(uid).get().then((value) {
        if (value.exists) {
          role = value.data()['role'];
        } else {
          role = -200;
        }
      });
      return role;
    } catch (e) {
      return -300;
    }
  }

  Future register(String email, String name, String photoURL, int role) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'name': name,
      'photoURL': photoURL,
      'role': role,
    });
  }
}
