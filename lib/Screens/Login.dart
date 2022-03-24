import 'package:flutter/material.dart'; // import tahap 1
import 'package:flutter/gestures.dart'; // import tahap 1
import 'package:flutter_form_builder/flutter_form_builder.dart'; // import tahap 2
import 'package:vigenesia/Screens/MainScreens.dart'; //Import tahap 4
import 'package:vigenesia/Screens/Constant/const.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:vigenesia/Screens/Register.dart'; // import tahap 3
import 'package:vigenesia/Models/Login_Model.dart';
//import 'dart:convert';
import'package:dio/dio.dart';
class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  String nama;
  String iduser;
  // ignore: unused_field
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
 // ignore: missing_return
 Future<LoginModels> postLogin(String email, String password) async{
   var dio = Dio();
   String baseurl = url;
  Map<String, dynamic> data = {"email": email, "password": password};
   {
    final response = await dio.post("$baseurl/vigenesia/api/login",
    data: data,
    options: Options(headers: {'Content-type': 'application/json'}));
    print("Respon -> ${response.data} + ${response.statusCode}");
    if (response.statusCode == 200) {
   final loginModel = LoginModels.fromJson(response.data);
   return loginModel;
 }
   }catche(e) {
   print("Failed To Load $e");
 // ignore: empty_statements
   };
 } 
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // awal tahap 1
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                
                  // awal children tahap 1
                  Text( 
                    'VIGENESIA',
                    style: TextStyle(color: Colors.black ,fontSize: 50, fontWeight: FontWeight.w500),
                  ), // akhir tahap 1
                  SizedBox(height: 20),
                  // awal tahap 2
                  Center(
                    child: Form(
                        child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          //awal children tahap 2
                          FormBuilderTextField(
                            name: "Email",
                            controller: emailController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.mail),
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(),
                                labelText: "Email"),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: "Password",
                            controller: passwordController,
                            decoration: InputDecoration( icon: Icon(Icons.lock),
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                          ), // akhir tahap 2
                          SizedBox(height: 20),
                          //awal tahap 3 membuat link sign up
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Tidak punya akun ?',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                  text: 'Daftar',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Register(key: null,)));
                                    },
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent)),
                            ]),
                          ), //akhir tahap 3 membuat sign up
                          //awal tahap 4
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: ()async{
                                await postLogin(emailController.text, passwordController.text).then((value) =>{
                             if (value != null){
                               setState(() {
                                 nama = value.data.nama;
                                 iduser = value.data.iduser;
                                 print("ini Data id ---->${iduser}");
                                 Navigator.pushReplacement(
                                   context,
                                   new MaterialPageRoute(
                                     builder: (BuildContext context) =>
                                     new MainScreens( 
                                     iduser: iduser ,
                                     nama: nama)));
                                  })
                             }
                             else if(value == null)
                             {
                              Flushbar(
                                 message:"Check Your Email / Password",
                                 duration:
                                 Duration(seconds: 5),
                                 backgroundColor:
                                 Colors.redAccent,
                                 flushbarPosition:
                                 FlushbarPosition.TOP,
                                 ).show(context)
                             }

                          });
                        },
                             child:  Text("masuk"),
                            ),
                          )
                         //Penutup tahapo 4
                        ], // penutup children  tahap 2
                      ),
                    )),
                  )
                ], // penutup children tahap 1
              ),
            ),
          ),
        ),
      ),
    );
  }
 }
