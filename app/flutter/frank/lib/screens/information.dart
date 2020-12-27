import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DocumentSnapshot>(context);
    if (data == null) return Loading();

    Map<String, dynamic> config = data.data();
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: EdgeInsets.only(right: 16.0, top: 8.0),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Text('Information',
                style: TextStyle(color: Colors.blueAccent, fontSize: 14.0))),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(config['information']['title'],
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 32,
                  ),
                  Text(config['information']['body'],
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            Container(
              child: Text(config['information']['link'],
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
