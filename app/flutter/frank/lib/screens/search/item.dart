import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/services/database.dart';
import 'package:frank/services/search.dart';

class SearchItem extends StatefulWidget {
  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  TextEditingController quantityController = TextEditingController();

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService()
          .searchItemByName(value.toString())
          .then((QuerySnapshot docs) {
        for (var i = 0; i < docs.docs.length; i++) {
          queryResultSet.add(docs.docs[i].data());
          queryResultSet.forEach((element) {
            if (element['_id'].startsWith(value)) {
              setState(() {
                tempSearchStore.add(element);
              });
            }
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['_id'].startsWith(value)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 48),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 48.0,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueAccent.withOpacity(.05),
                ),
                child: Center(
                  child: TextField(
                    onChanged: (value) => initiateSearch(value.toLowerCase()),
                    autofocus: true,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.only(left: 24.0),
                        hintText: 'Search: (eg. \'BIO\')',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var i = 0; i < tempSearchStore.length; i++)
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 8.0),
                        child: ListTile(
                            title: Text(tempSearchStore[i]['name'].toString(),
                                style: TextStyle(
                                  fontSize: 14.0,
                                )),
                            trailing:
                                Text(tempSearchStore[i]['quantity'].toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    )),
                            onTap: () {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Theme(
                                        data: Theme.of(context).copyWith(
                                          splashFactory:
                                              InkRipple.splashFactory,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context)),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16, horizontal: 16),
                                              child: Text(
                                                tempSearchStore[i]['name'],
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ),
                                            ),
                                            Container(
                                              width: 60,
                                              child: TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none),
                                                style: TextStyle(
                                                  fontSize: 32.0,
                                                ),
                                                controller: quantityController
                                                  ..text = tempSearchStore[i]
                                                          ['quantity']
                                                      .toString(),
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 24.0,
                                              width: 60.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  onPressed: () {},
                                                  onLongPress: () {
                                                    // int idx = product.indexOf(item);

                                                    // String id = data.docs[idx].id;

                                                    DatabaseService()
                                                        .deleteItem(
                                                            tempSearchStore[i]
                                                                ['_id']);
                                                    Navigator.pop(context);
                                                  },
                                                  color: Colors.red[600],
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  onPressed: () {
                                                    int quantity = int.parse(
                                                        quantityController
                                                            .text);
                                                    DatabaseService()
                                                        .updateItem(
                                                            tempSearchStore[i]
                                                                ['_id'],
                                                            quantity);
                                                    Navigator.pop(context);
                                                  },
                                                  color: Colors.blueAccent,
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
