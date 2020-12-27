import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/user.dart';
import 'package:frank/screens/authenticate/authenticate.dart';
import 'package:frank/screens/information.dart';
import 'package:frank/services/account.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DocumentSnapshot>(context);
    if (data == null) return Loading();

    Map<String, dynamic> config = data.data();

    final user = Provider.of<MyUser>(context);

    if (config['api'] > 0) {
      return Information();
    } else {
      if (user == null) {
        return Authenticate();
      } else {
        return StreamProvider<Data>.value(
          value: AccountService(uid: user.email).myData,
          child: Home(),
        );
      }
    }
  }
}
