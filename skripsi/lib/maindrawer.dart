import 'package:flutter/material.dart';
import 'package:skripsi/Screens/main/priority.dart';
import 'package:skripsi/Screens/main/transaction.dart';
import 'package:skripsi/Screens/main/profile.dart';
import 'package:skripsi/Screens/login/login.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Lee Wang",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Software Engenieer",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      ListTile(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PriorityScreen()));
        },
        leading: Icon(
          Icons.assessment,
          color: Colors.white,
        ),
        title: Text(
          "Prioritas Produksi",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      ListTile(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TransactionScreen()));
        },
        leading: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        title: Text(
          "Transaksi",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      ListTile(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
        },
        leading: Icon(
          Icons.person,
          color: Colors.white,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      ListTile(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        leading: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        title: Text(
          "Logout",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}
