import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skripsi/Screens/login/login.dart';

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
  Future _priority;
  List mydata;
  List unfilterData;
  Future loadJsonData() async {
    var data = await http.get("http://192.168.43.184/skripsi/api/priority_api");

    var jsonData = json.decode(data.body);

    List<Priority> prioritys = [];
    if (jsonData['response_message'] == 'Data Minimal 2 Barang') {
      prioritys = null;
      mydata = prioritys;
      this.unfilterData = mydata;
    } else {
      for (var p in jsonData['data']) {
        Priority priority = Priority(
            p["index"],p["nomer"].toString(), p["customer"], p["barang"], p["jumlah"], p["detail"]);

        prioritys.add(priority);
        mydata = prioritys;
        this.unfilterData = mydata;
      }
    }
    return prioritys;
  }

  @override
  void initState() {
    super.initState();
    _priority = loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF016CB1),
        title: Text("Prioritas Produksi"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()))
            },
            child: Icon(
                Icons.logout,
            ),
          )
        ),
      ],
      ),
      //Now we are going to open a new file
      // where we will create the layout of the Drawer
      // drawer: Theme(
      //   data: Theme.of(context).copyWith(
      //     canvasColor: Color(0xFF016CB1),
      //   ),
      //   // child: Drawer(
      //   //   child: MainDrawer(),
      //   // ),
      // ),
      body: Container(
        child: FutureBuilder(
          future: _priority,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                      child: Text(
                "Data Minimal 2 Barang",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )));
            } else {
              // snapshot.data[index].customer
              return ListView.builder(
                itemBuilder: (context, index) {
                  return index == 0 ? _searchBar() : _listItem(index - 1);
                },
                itemCount: unfilterData.length + 1,
              );
            }
          },
        ),
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
          color: Colors.red[900],
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new RaisedButton(
          child: Text("Yakin"),
          color: Colors.green[900],
          onPressed: () {
            finishPriority(id);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
            Fluttertoast.showToast(
              msg: "Barang $barang milik $customer berhasil diselesaikan",
              toastLength: Toast.LENGTH_LONG,
            );
          },
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void finishPriority(id) async {
    var url = "http://192.168.43.184/skripsi/api/priority_api/finishPriority";
    var data = {
      "nama_barang_detail": id,
    };

    await http.post(url, body: data);
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Cari Data Customer ...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            unfilterData = mydata.where((note) {
              var noteTitle = note.customer.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 3),
        child: ListTile(
          title: Text(
            unfilterData[index].nomer +". "+ unfilterData[index].customer,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(
                unfilterData[index].barang,
                style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
              ),
              Text(
                "(" + unfilterData[index].jumlah + " pcs)",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
              ),
            ],
          ),
          trailing: GestureDetector(
            child: Icon(Icons.check_circle_rounded),
            onTap: () {
              confirm(unfilterData[index].detail, unfilterData[index].barang,
                  unfilterData[index].customer);
            },
          ),
        ),
      ),
    );
  }
}

class Priority {
  final int index;
  final String nomer;
  final String customer;
  final String barang;
  final String jumlah;
  final String detail;

  Priority(this.index,this.nomer, this.customer, this.barang, this.jumlah, this.detail);
}
