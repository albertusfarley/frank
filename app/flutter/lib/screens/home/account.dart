import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/user.dart';
import 'package:frank/services/auth.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final myData = Provider.of<Data>(context);

    if (user == null || myData == null) return Loading();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 64, horizontal: 32),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              // color: Colors.blueAccent,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(256.0),
                child: Image.network(user.photoURL),
              ),
            ),
            Text(
              'Role',
              style: TextStyle(color: Colors.blueAccent),
            ),
            Text(myData.roleName, style: TextStyle(fontSize: 20)),
            SizedBox(height: 16.0),
            Text(
              'Name',
              style: TextStyle(color: Colors.blueAccent),
            ),
            Text(user.displayName, style: TextStyle(fontSize: 20)),
            SizedBox(height: 16.0),
            Text(
              'Email',
              style: TextStyle(color: Colors.blueAccent),
            ),
            Text(user.email, style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            MaterialButton(
              onPressed: () {
                _auth.signOut();
              },
              color: Colors.blueAccent,
              child: Text('Sign Out', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
