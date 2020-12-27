import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:frank/models/data.dart';
import 'package:frank/models/role.dart';
import 'package:frank/models/users.dart';
import 'package:frank/services/database.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  String currRole = '';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MyUsers>(context);
    final myData = Provider.of<Data>(context);

    Role role = Role();
    Map userRole = {};

    Map roles = role.getRoles();
    List<int> codes = roles.keys.toList();

    if (data == null || myData == null) return Loading();

    int myRole = myData.role;
    if (myRole == 1) {
      codes.removeWhere((code) => code == 0 || code == 1);
    }

    List users = data.data.docs.map((doc) => doc.data()).toList();
    if (myRole == 1) {
      List<int> roleUnderAdmin = role.roleUnderAdmin;

      users = users
          .where((user) =>
              roleUnderAdmin.contains(user['role']) ||
              !role.getAllCodes().contains(user['role']))
          .toList();
    }

    for (int role in codes) {
      userRole[role] = users.where((user) => user['role'] == role).toList();
    }

    List<Widget> tabs = [
      Tab(
        text: 'All',
      ),
      for (int code in codes)
        Tab(
          text: role.getName(code),
        )
    ];

    Widget allUsers = users.length == 0
        ? Center(
            child: Text('No users.'),
          )
        : Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 8),
            child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: ListView(
                  children: [
                    for (var user in users) myListTile(myRole, user, role)
                  ],
                )));

    List<Widget> tabBarView = [
      allUsers,
      for (int code in codes)
        Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 8),
            child: userRole[code].length == 0
                ? Center(
                    child: Text('No users.'),
                  )
                : ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      for (var user in userRole[code])
                        myListTile(myRole, user, role)
                    ],
                  ))
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Container(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Users',
                style: TextStyle(color: Colors.black),
              )),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: DefaultTabController(
              length: codes.length + 1,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    child: ButtonsTabBar(
                      backgroundColor: Colors.blueAccent.withOpacity(.1),
                      unselectedBackgroundColor: Colors.white,
                      labelStyle: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(color: Colors.grey),
                      borderWidth: 1,
                      unselectedBorderColor: Colors.grey[300],
                      borderColor: Colors.transparent,
                      radius: 100,
                      tabs: tabs,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: TabBarView(children: tabBarView),
                  ),
                ],
              ),
            )));
  }

  Widget myListTile(var myRole, var user, var role) {
    return Container(
      padding: EdgeInsets.only(bottom: 32),
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: Image.network(user['photoURL'])),
        title: Container(
          height: 48,
          padding: EdgeInsets.only(left: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user['name'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                user['email'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
        ),
        trailing: DropdownButton<String>(
          value: role.getName(user['role']),
          elevation: 16,
          style: TextStyle(color: Colors.blueAccent),
          onChanged: (String newRole) {
            setState(() {
              DatabaseService()
                  .updateUser(user['email'], role.getCode(newRole));
            });
          },
          items: role
              .getAllNamesByRole(myRole)
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
