import 'package:flutter/material.dart';

class Unknown extends StatefulWidget {
  @override
  _UnknownState createState() => _UnknownState();
}

class _UnknownState extends State<Unknown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Requesting admin for the access...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: 16,
              height: 2,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
