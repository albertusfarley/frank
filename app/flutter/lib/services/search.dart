import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchTypeByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('series')
        .where('param', isEqualTo: searchField.substring(0, 1))
        .get();
  }

  searchItemByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('items')
        .where('param', isEqualTo: searchField.substring(0, 1))
        .get();
  }
}
