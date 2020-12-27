import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frank/models/type.dart';
import 'package:frank/models/types.dart';
import 'package:frank/models/users.dart';

class DatabaseService {
  final DocumentReference configDocument =
      FirebaseFirestore.instance.collection('configs').doc('general');

  final DocumentReference stockDocument =
      FirebaseFirestore.instance.collection('fans').doc('stock');
  final CollectionReference typesCollection =
      FirebaseFirestore.instance.collection('types');
  final CollectionReference seriesCollection =
      FirebaseFirestore.instance.collection('series');
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  updateItem(String id, int quantity) {
    itemsCollection.doc(id).update({'quantity': quantity});
  }

  updateUser(String id, int role) {
    usersCollection.doc(id).update({'role': role});
  }

  Types _generateTypes(QuerySnapshot snapshot) {
    var data = snapshot.docs.map((doc) => doc.data()).toList();
    return Types(data: data);
  }

  Stream<DocumentSnapshot> get config {
    return configDocument.snapshots();
  }

  Stream<Types> get types {
    return typesCollection.orderBy('index').snapshots().map(_generateTypes);
  }

  SingleType _generateSingleTypes(QuerySnapshot snapshot) {
    var data = snapshot.docs.map((doc) => doc.data()).toList()[0];
    return data == null ? null : SingleType(data: data);
  }

  Stream<SingleType> typeByID(String id) {
    return typesCollection
        .where('_id', isEqualTo: id)
        .snapshots()
        .map((_generateSingleTypes));
  }

  Stream<QuerySnapshot> get series {
    return seriesCollection.snapshots();
  }

  Stream<QuerySnapshot> seriesByType(String type) {
    return seriesCollection.where('type', isEqualTo: type).snapshots();
  }

  Stream<QuerySnapshot> itemsBySeries(String series) {
    return itemsCollection.where('series', isEqualTo: series).snapshots();
  }

  Stream<QuerySnapshot> get items {
    return itemsCollection.orderBy('name').snapshots();
  }

  MyUsers _generateUsers(QuerySnapshot doc) {
    return MyUsers(data: doc);
  }

  Stream<MyUsers> get users {
    return usersCollection.orderBy('name').snapshots().map(_generateUsers);
  }

  addItem(String name, String type, String series, int quantity) {
    String id = name
        .toLowerCase()
        .replaceAll(' - ', '_')
        .replaceAll(' -', '_')
        .replaceAll('_ ', '_')
        .replaceAll('  ', '_')
        .replaceAll(' ', '_')
        .replaceAll('-', '_')
        .replaceAll('/', '_')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('"', '')
        .replaceAll(',', '.');

    return itemsCollection.doc(id).set({
      '_id': id,
      'name': name,
      'type': type,
      'series': series,
      'quantity': quantity,
      'param': id[0],
    });
  }

  deleteItem(String id) {
    itemsCollection.doc(id).delete();
  }
}
