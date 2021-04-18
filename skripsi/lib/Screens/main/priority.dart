import 'package:flutter/material.dart';
import '../../maindrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PriorityScreen(),
    );
  }
}

class PriorityScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PriorityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF016CB1),
        title: Text("Prioritas Produksi"),
      ),
      //Now we are going to open a new file
      // where we will create the layout of the Drawer
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF016CB1),
        ),
        child: Drawer(
          child: MainDrawer(),
        ),
      ),
      body: Center(
        child: Text("List Produksi"),
      ),
    );
  }
}
