import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/user.dart';
import 'package:frank/screens/home/product.dart';
import 'package:frank/services/account.dart';
import 'package:frank/services/search.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class SearchType extends StatefulWidget {
  @override
  _SearchTypeState createState() => _SearchTypeState();
}

class _SearchTypeState extends State<SearchType> {
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
          .searchTypeByName(value.toString())
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
    final data = Provider.of<Data>(context);
    final user = Provider.of<MyUser>(context);

    if (data == null || user == null) return Loading();
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
                        padding:
                            EdgeInsets.only(bottom: 36, left: 16, right: 8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StreamProvider<Data>.value(
                                          value: AccountService(uid: user.email)
                                              .myData,
                                          child: Product(
                                            seriesData: tempSearchStore[i],
                                          ),
                                        )));
                          },
                          leading: SizedBox(
                            height: 64,
                            width: 64,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.blueAccent.withOpacity(.1),
                              ),
                              child: Image.network(
                                  tempSearchStore[i]['thumbnail'],
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                          title: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tempSearchStore[i]['name'] == '_'
                                      ? 'Other'
                                      : tempSearchStore[i]['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                    tempSearchStore[i]['code'] == '_'
                                        ? ''
                                        : tempSearchStore[i]['code'],
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
