import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/type.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class Item extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    final typeStream = Provider.of<SingleType>(context);
    final data = Provider.of<QuerySnapshot>(context);

    if (data == null) return Loading();
    Map typeData = typeStream.data;

    List item = data.docs.map((doc) => doc.data()).toList();
    item.sort((a, b) => a['name'].compareTo(b['name']));

    if (typeData['isCustom']) {
      item.removeWhere((i) => i['quantity'] == 0);
    }
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.only(top: 16),
                alignment: Alignment.topCenter,
                child: Text('Stock',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ),
            item.length == 0
                ? Center(
                    child: Text('No Items.'),
                  )
                : Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return;
                      },
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          for (var i = 0; i < item.length; i++)
                            ListTile(
                              title: Text(item[i]['name'],
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  )),
                              trailing: Text(item[i]['quantity'].toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  )),
                            ),
                          SizedBox(
                            height: 240,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
