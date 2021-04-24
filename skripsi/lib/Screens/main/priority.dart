import 'dart:convert';
import 'package:flutter/material.dart';
import '../../maindrawer.dart';
import 'package:http/http.dart' as http;

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
  List data;
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("http://192.168.43.184/skripsi/api/priority_api"),
        headers: {"Accept": "application/json"});
    setState(() {
      data = json.decode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

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
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 3),
              child: ListTile(
                title: Text(
                  data[index]["customer"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Text(
                      data[index]["barang"],
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade600),
                    ),
                    Text(
                      "(" + data[index]["jumlah"] + " pcs)",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.check_circle_rounded),
                  onTap: () {
                    confirm(data[index]["detail"], data[index]["barang"],
                        data[index]["customer"]);
                  },
                ),
              ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text(
              //       data[index]["barang"],
              //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       "Jumlah : ( " + data[index]["jumlah"] + " Pcs )",
              //       style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
              //     ),
              //     Text(
              //       "Customer : " + data[index]["customer"],
              //       style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
              //     ),
              //   ],
              // ),
            ),
          );
        },
      ),
    );
  }

  void confirm(id, barang, customer) {
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("Yakin ingin menyelesaikan pesanan $barang milik $customer"),
      actions: <Widget>[
        new RaisedButton(
          child: Text("Tidak"),
          color: Colors.redAccent,
          onLongPress: () {},
        ),
        new RaisedButton(
          child: Text("Yakin"),
          color: Color(0xFF016CB1),
          onLongPress: () {},
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
