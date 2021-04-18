import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skripsi/Screens/login/login.dart';
import 'package:skripsi/components/background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  @override
  GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF016CB1),
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama harus di isi';
                    }
                    return null;
                  },
                  controller: etcName,
                  decoration: InputDecoration(labelText: "Nama"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email harus di isi';
                    }
                    return null;
                  },
                  controller: etcEmail,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password harus di isi';
                    } else if (!(value.length > 8)) {
                      return 'Password harus minimal 8 karakter';
                    }
                    return null;
                  },
                  controller: etcPassword,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () {
                    if (_registerFormKey.currentState.validate()) {
                      registerUser();
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "REGISTER",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: Text(
                    "Sudah punya akun? Login sekarang",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF016CB1)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController etcName = new TextEditingController();
  TextEditingController etcEmail = new TextEditingController();
  TextEditingController etcPassword = new TextEditingController();

  void registerUser() async {
    var url = "http://192.168.43.184/skripsi/api/register_api";
    var data = {
      "nama_user": etcName.text,
      "email": etcEmail.text,
      "password": etcPassword.text,
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
  }
}
