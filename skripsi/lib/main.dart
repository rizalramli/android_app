import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Skripsi'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signin = true;

  TextEditingController namectrl, emailctrl, passctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.blue,
            ),
            boxUi(),
          ],
        ));
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else
      setState(() {
        signin = true;
      });
  }

  void registerUser() async {
    setState(() {
      processing = true;
    });
    var url = "http://192.168.43.184/skripsi/api/register_api";
    var data = {
      "email": emailctrl.text,
      "nama_user": namectrl.text,
      "password": passctrl.text,
    };

    var res = await http.post(url, body: data);
    var response = json.decode(res.body);
    if (response['response_message'] == "Email sudah digunakan") {
      Fluttertoast.showToast(
          msg: "Email sudah digunakan, Silahkan Login",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (response['response_message'] == "Sukses Registrasi") {
        Fluttertoast.showToast(
            msg: "Sukses Registrasi", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(
            msg: "Gagal Registrasi", toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
    });
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });
    var url = "http://192.168.43.184/skripsi/api/login_api";
    var data = {
      "email": emailctrl.text,
      "password": passctrl.text,
    };

    var res = await http.post(url, body: data);
    var response = json.decode(res.body);
    print(jsonDecode(res.body));
    if (response['response_message'] == "Belum Punya Akun") {
      Fluttertoast.showToast(
          msg: "Anda belum mempunyai akun,silahkan registrasi",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (response['response_message'] == "Password Salah") {
        Fluttertoast.showToast(
            msg: "Password anda salah", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(
            msg: "Sukses Login", toastLength: Toast.LENGTH_SHORT);
      }
    }

    setState(() {
      processing = false;
    });
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'SIGN IN',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            signin == true ? signInUi() : signUpUi(),
          ],
        ),
      ),
    );
  }

  Widget signInUi() {
    return Column(
      children: <Widget>[
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'email'),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
              ),
              hintText: 'pass'),
        ),
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
            onPressed: () => userSignIn(),
            child: processing == false
                ? Text(
                    'Sign In',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0, color: Colors.blue),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  )),
      ],
    );
  }

  Widget signUpUi() {
    return Column(
      children: <Widget>[
        TextField(
          controller: namectrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'name'),
        ),
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'email'),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
              ),
              hintText: 'pass'),
        ),
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
            onPressed: () => registerUser(),
            child: processing == false
                ? Text(
                    'Sign Up',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0, color: Colors.blue),
                  )
                : CircularProgressIndicator(backgroundColor: Colors.red)),
      ],
    );
  }

  // now we will setup php and database
//thank you
}
