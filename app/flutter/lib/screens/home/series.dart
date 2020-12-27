import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/user.dart';
import 'package:frank/screens/home/product.dart';
import 'package:frank/services/account.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class MySeries extends StatefulWidget {
  MySeries();

  @override
  _MySeriesState createState() => _MySeriesState();
}

class _MySeriesState extends State<MySeries> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuerySnapshot>(context);
    final user = Provider.of<MyUser>(context);

    if (data == null || user == null) return Loading();

    List series = data.docs.map((doc) => doc.data()).toList();
    series.sort((a, b) => a['name'].compareTo(b['name']));

    double containerSize = MediaQuery.of(context).size.width / 2;
    double cardsWidth = containerSize / 1.1;

    List<Widget> cards = [
      for (int i = 0; i < series.length; i++)
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StreamProvider<Data>.value(
                          value: AccountService(uid: user.email).myData,
                          child: Product(
                            seriesData: series[i],
                          ),
                        )));
          },
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: cardsWidth,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(24.0),
                      child: SizedBox(
                        height: containerSize / 1.5,
                        width: containerSize / 1.5,
                        child: series[i]['thumbnail'] == ''
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text('No image.',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.grey)),
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: series[i]['thumbnail'],
                                fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            series[i]['code'] == '_'
                                ? 'Other'
                                : series[i]['code'],
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Text(
                            series[i]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ),
    ];

    if (cards.length == 1) {
      cards += <Widget>[
        SizedBox(
          width: cardsWidth,
        )
      ];
    }

    return Scaffold(
      body: series.length == 0
          ? Center(
              child: Text('No items.',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            )
          : Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ListView(physics: ClampingScrollPhysics(), children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 4,
                    runSpacing: 4,
                    children: cards,
                  ),
                ),
              ]),
            ),
    );
  }
}
