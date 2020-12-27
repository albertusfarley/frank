import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/types.dart';
import 'package:frank/models/user.dart';
import 'package:frank/screens/search/type.dart';
import 'package:frank/services/account.dart';
import 'package:frank/services/auth.dart';
import 'package:frank/services/database.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';
import 'series.dart';

class MyTypes extends StatefulWidget {
  @override
  _MyTypesState createState() => _MyTypesState();
}

class _MyTypesState extends State<MyTypes> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Types>(context);
    final user = Provider.of<MyUser>(context);
    final myData = Provider.of<Data>(context);

    if (data == null || user == null || myData == null) return Loading();
    List types = data.data.toList();

    List<Widget> tabs = [
      for (var i = 0; i < types.length; i++)
        Tab(
          text: types[i]['name'] == '_' ? 'Other' : types[i]['name'],
        )
    ];

    List<Widget> tabBarViews = [
      for (var i = 0; i < types.length; i++)
        StreamProvider<QuerySnapshot>.value(
          value: DatabaseService().seriesByType(types[i]['_id']),
          child: MySeries(),
        ),
    ];

    void displayBottomSheet(BuildContext context) {
      showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 9,
              padding: EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  _auth.signOut();
                },
                child: Text(
                  'Sign out',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16),
                ),
              ),
            );
          });
    }

    return DefaultTabController(
        length: types.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            brightness: Brightness.light,
            title: Text('  Home', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.blueAccent),
            elevation: 0,
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return;
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StreamProvider<Data>.value(
                                          value: AccountService(uid: user.email)
                                              .myData,
                                          child: SearchType())),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .7,
                            height: 48.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.blueAccent.withOpacity(.05),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Search: (eg. \'BIO\')',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          displayBottomSheet(context);
                        },
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(256.0),
                            child: CachedNetworkImage(
                                imageUrl: user.photoURL, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32),
                    child: TabBar(
                        labelColor: Colors.blueAccent,
                        indicatorColor: Colors.blueAccent,
                        isScrollable: true,
                        unselectedLabelColor: Colors.black,
                        tabs: tabs),
                  ),
                  Expanded(
                    child: TabBarView(children: tabBarViews),
                  ),
                ],
              )),
        ));
  }
}
