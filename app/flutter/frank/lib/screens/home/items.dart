import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/screens/home/add_item.dart';
import 'package:frank/screens/search/item.dart';
import 'package:frank/services/database.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class MyItems extends StatefulWidget {
  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuerySnapshot>(context);

    if (data == null) return Loading();
    List product = data.docs.map((doc) => doc.data()).toList();

    Map productMap = {};

    for (var item in product) {
      String param = item['name'][0];

      if (productMap[param] == null) {
        productMap[param] = [item];
      } else {
        productMap[param] += [item];
      }
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Container(
              padding: EdgeInsets.only(left: 8),
              child: Text('My Items', style: TextStyle(color: Colors.black))),
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                splashFactory: InkRipple.splashFactory,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StreamProvider<QuerySnapshot>.value(
                                    value: DatabaseService().series,
                                    child: AddItem())));
                  },
                ),
              ),
            ),
          ],
        ),
        body: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fontFamily: 'RobotoCondensed',
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: product.length == 0
                ? Center(
                    child: Text('No Items.'),
                  )
                : Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchItem()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 48.0,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.blueAccent.withOpacity(.05),
                          ),
                          child: Center(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.search),
                                  contentPadding: EdgeInsets.only(left: 24.0),
                                  hintText: 'Search: (eg. \'BIO\')',
                                  fillColor: Colors.blueAccent,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            for (var i in productMap.keys)
                              ListView(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  children: [
                                    ListTile(
                                      title: Text(
                                        i,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    for (var item in productMap[i])
                                      ListTile(
                                          title: Text(item['name'].toString(),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              )),
                                          trailing:
                                              Text(item['quantity'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                  )),
                                          onTap: () {
                                            return showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        splashFactory: InkRipple
                                                            .splashFactory,
                                                        splashColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: IconButton(
                                                                icon: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context)),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        16,
                                                                    horizontal:
                                                                        16),
                                                            child: Text(
                                                              item['name'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 60,
                                                            child: TextField(
                                                              autofocus: true,
                                                              decoration: InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              style: TextStyle(
                                                                fontSize: 32.0,
                                                              ),
                                                              controller: quantityController
                                                                ..text = item[
                                                                        'quantity']
                                                                    .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 24.0,
                                                            width: 60.0,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              RaisedButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0)),
                                                                onPressed:
                                                                    () {},
                                                                onLongPress:
                                                                    () {
                                                                  DatabaseService()
                                                                      .deleteItem(
                                                                          item[
                                                                              '_id']);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                color: Colors
                                                                    .red[600],
                                                                child: Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              RaisedButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0)),
                                                                onPressed: () {
                                                                  int quantity =
                                                                      int.parse(
                                                                          quantityController
                                                                              .text);
                                                                  DatabaseService()
                                                                      .updateItem(
                                                                          item[
                                                                              '_id'],
                                                                          quantity);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                color: Colors
                                                                    .blueAccent,
                                                                child: Text(
                                                                  'Submit',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          })
                                  ]),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }
}
