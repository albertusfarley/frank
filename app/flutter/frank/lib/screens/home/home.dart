import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/types.dart';
import 'package:frank/models/user.dart';
import 'package:frank/models/users.dart';
import 'package:frank/screens/home/items.dart';
import 'package:frank/screens/home/types.dart';
import 'package:frank/screens/home/users.dart';
import 'package:frank/services/database.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

import '../message.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  int prevRole = -1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final myData = Provider.of<Data>(context);
    final configProvider = Provider.of<DocumentSnapshot>(context);
    if (configProvider == null) return Loading();

    Map<String, dynamic> config = configProvider.data();

    if (user == null || myData == null) return Loading();

    int myRole = myData.role;
    if (myRole != prevRole) {
      setState(() {
        prevRole = myRole;
        _selectedIndex = 0;
      });
    }

    List<Widget> _widgetOptions = <Widget>[
      StreamProvider<Types>.value(
          value: DatabaseService().types, child: MyTypes()),
    ];

    List<BottomNavigationBarItem> _bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
    ];

    if (myRole == 0 || myRole == 1) {
      Widget usersWidget = StreamProvider<MyUsers>.value(
          value: DatabaseService().users, child: Users());

      BottomNavigationBarItem usersBar = BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('Users'),
      );

      _widgetOptions.insert(1, usersWidget);
      _bottomNavigationBarItems.insert(1, usersBar);

      Widget editWidget = StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().items,
        child: MyItems(),
      );
      BottomNavigationBarItem editBar = BottomNavigationBarItem(
        icon: Icon(Icons.folder),
        title: Text('Items'),
      );

      _widgetOptions.insert(1, editWidget);
      _bottomNavigationBarItems.insert(1, editBar);
    }

    return config['flag'] == true && myRole != 0
        ? Message()
        : Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: _bottomNavigationBarItems.length == 1
                ? null
                : Theme(
                    data: Theme.of(context).copyWith(
                      splashFactory: InkRipple.splashFactory,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      items: _bottomNavigationBarItems,
                      currentIndex: _selectedIndex,
                      selectedItemColor: Colors.blueAccent,
                      onTap: _onItemTapped,
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                  ),
          );
  }
}
