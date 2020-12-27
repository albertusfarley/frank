import 'package:flutter/material.dart';
import 'package:frank/services/auth.dart';
import 'package:frank/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 64),
                          child: Image.asset('images/sign_in.png')),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                          text: 'Customers are Partners',
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                          text: 'Give Our Best',
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Exclusively Made for You',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 48,
                  width: 136,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    onPressed: () async {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithGoogle();
                      if (result == null) {
                        setState(() {
                          print('Error singing in');
                          loading = false;
                        });
                      } else {
                        print('Signed in');
                        print('uid: ${result.uid}');
                      }
                    },
                    color: Colors.blueAccent,
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
  }
}
