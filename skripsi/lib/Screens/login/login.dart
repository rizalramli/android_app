import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skripsi/Screens/register/register.dart';
import 'package:skripsi/components/background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi/Screens/main/priority.dart';

class LoginScreen extends StatelessWidget {
  @override
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // child: Image.asset("assets/images/main.png",
                //     width: size.width * 0.20),
                // alignment: Alignment.center,
                child: Text(
                  "Lilik Collection",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.bold,
                      color: Color(0xFF016CB1),
                      fontSize: 36),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF016CB1),
                      fontSize: 20),
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
                      return 'Email harus di isi';
                    }
                    return null;
                  },
                  controller: etcEmail,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
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
                    }
                    return null;
                  },
                  controller: etcPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //   child: Text(
              //     "Forgot your password?",
              //     style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
              //   ),
              // ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () {
                    if (_loginFormKey.currentState.validate()) {
                      userSignIn(context);
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
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //   child: GestureDetector(
              //     onTap: () => {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => RegisterScreen()))
              //     },
              //     child: Text(
              //       "Belum punya akun? Registrasi sekarang",
              //       style: TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.bold,
              //           color: Color(0xFF016CB1)),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController etcEmail = new TextEditingController();
  TextEditingController etcPassword = new TextEditingController();

  void userSignIn(BuildContext context) async {
    var url = "http://192.168.43.184/skripsi/api/login_api";
    var data = {
      "email": etcEmail.text,
      "password": etcPassword.text,
    };

    var res = await http.post(url, body: data);
    var response = json.decode(res.body);
    if (response['response_message'] == "Belum Punya Akun") {
      Fluttertoast.showToast(
          msg: "Anda belum mempunyai akun,silahkan registrasi",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (response['response_message'] == "Password Salah") {
        Fluttertoast.showToast(
            msg: "Password anda salah", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (response['response_message'] == "Hak akses anda bukan pemilik") {
            Fluttertoast.showToast(
            msg: "Hak akses anda bukan pemilik", toastLength: Toast.LENGTH_SHORT);
        } 
        else 
        {
            Fluttertoast.showToast(
                msg: "Sukses Login", toastLength: Toast.LENGTH_SHORT);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PriorityScreen()));
        }
      }
    }
  }
}
