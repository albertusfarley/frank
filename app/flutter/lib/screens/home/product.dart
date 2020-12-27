import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/type.dart';
import 'package:frank/screens/home/item.dart';
import 'package:frank/services/database.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}

class Product extends StatefulWidget {
  final dynamic seriesData;
  Product({this.seriesData});

  @override
  _ProductState createState() => _ProductState(seriesData: seriesData);
}

class _ProductState extends State<Product> {
  final dynamic seriesData;

  _ProductState({this.seriesData});

  PanelController _pc = new PanelController();
  bool collapsedButtonVisibility = false;

  @override
  Widget build(BuildContext context) {
    final myData = Provider.of<Data>(context);

    if (myData == null) return Loading();

    int role = myData.role;
    List<int> authorizeRole = [-1, 0, 1];

    double paddingSize = 16;

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    Widget _descriptionWidget(String key, String value, {bool isBold: false}) {
      FontWeight bold;

      if (isBold == true)
        bold = FontWeight.bold;
      else
        bold = null;

      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(key.toString().capitalizeFirstofEach,
                  style: TextStyle(fontWeight: bold, fontSize: 20.0)),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(value == '' ? '-' : value,
                    textAlign: TextAlign.justify)),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Visibility(
          visible: false,
          child: Text('Stock',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SlidingUpPanel(
            isDraggable: authorizeRole.contains(role),
            controller: _pc,
            panelSnapping: true,
            defaultPanelState: PanelState.CLOSED,
            minHeight: authorizeRole.contains(role)
                ? MediaQuery.of(context).size.height / 12
                : 0,
            maxHeight: authorizeRole.contains(role)
                ? MediaQuery.of(context).size.height
                : 0,
            onPanelClosed: () {
              setState(() {
                collapsedButtonVisibility = false;
              });
            },
            onPanelOpened: () {
              setState(() {
                collapsedButtonVisibility = true;
              });
            },
            collapsed: GestureDetector(
              onTap: () {
                _pc.open();
                setState(() {
                  if (authorizeRole.contains(role))
                    collapsedButtonVisibility = true;
                });
              },
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: radius),
                child: Center(
                  child: Text('Stock',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.height / 3,
                        height: MediaQuery.of(context).size.height / 3,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height / 16),
                        child: Center(
                          child: seriesData['image'] == ''
                              ? Text(
                                  'No image.',
                                  style: TextStyle(color: Colors.grey),
                                )
                              : CachedNetworkImage(
                                  imageUrl: seriesData['image'],
                                ),
                        )),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: paddingSize,
                          ),
                          Text(
                            seriesData['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.blueAccent[700]),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            seriesData['code'],
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                          SizedBox(
                            height: paddingSize,
                          ),
                          _descriptionWidget('description',
                              seriesData['descriptions']['description'],
                              isBold: true),
                          Column(
                            children: [
                              for (var key in seriesData['descriptions'].keys)
                                if (key != 'description')
                                  _descriptionWidget(
                                      key, seriesData['descriptions'][key]),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            panel: StreamProvider<SingleType>.value(
              value: DatabaseService().typeByID(seriesData['type']),
              child: StreamProvider<QuerySnapshot>.value(
                  value: DatabaseService().itemsBySeries(seriesData['_id']),
                  child: Item()),
            ),
          ),
          Visibility(
              visible: collapsedButtonVisibility,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      collapsedButtonVisibility = false;
                    });
                    _pc.close();
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Icon(Icons.keyboard_arrow_down,
                        color: Colors.redAccent),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
