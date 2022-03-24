

// ignore_for_file: unused_import

import 'package:flutter/material.dart'; // import tahap 1
import 'package:another_flushbar/flushbar.dart'; // import tahap 2
import 'package:flutter_form_builder/flutter_form_builder.dart'; // import tahap 2
import 'package:vigenesia/Screens/Constant/const.dart';
import 'package:vigenesia/Screens/Login.dart'; // import tahap 1
import 'package:dio/dio.dart';
class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


 String baseurl = url;

Future postRegister(
  String nama, String profesi, String email, String password) 
  async {
 var dio = Dio();
 dynamic data = {
 "nama": nama,
 "profesi": profesi,
 "email": email,
 "password": password
 };
 try {
   final response = await dio.post("$baseurl/vigenesia/api/registrasi/",
   data: data,
   options: Options(headers: {'Content-type': 'application/json'})
   );
   print("Respon -> ${response.data} + ${response.statusCode}");
    if (response.statusCode == 200) {
    return response.data;
   }
 } catch (e) {
 print("Failed To Load $e");
 }
 }

  TextEditingController nameController = TextEditingController(); //tahap 2
  TextEditingController profesiController = TextEditingController(); //tahap 3
  TextEditingController emailController = TextEditingController(); // tahap 4
  TextEditingController passwordController = TextEditingController(); //tahap 5
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // awaal scaffold
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // pembuka children tahap 1
                  Text(
                    "Register Your Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ), // akhir tahap 1
                  SizedBox(height: 50),
                  FormBuilderTextField(
                    name: "name",
                    controller: nameController,
                    decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(),
                        labelText: "Nama"),
                  ),
                  SizedBox(height: 20),

                  FormBuilderTextField(
                    name: "profesi",
                    controller: profesiController,
                    decoration: InputDecoration(
                       icon: Icon(Icons.person),
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(),
                        labelText: "Profesi"),
                  ), //akhir tahap 3
                  //awal tahap 4
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "email",
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(),
                        labelText: "Email"),
                  ), //akhir tahap 4
                  //awal tahap5
                  SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    obscureText:
                        true, // <-- Buat bikin setiap inputan jadi bintang " * "
                    name: "password",
                    controller: passwordController,
                    decoration: InputDecoration(icon: Icon(Icons.remove_red_eye),
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(),
                        labelText: "Password"),
                  ), //akhir tahap 5
                  // awal tahap 6
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: ()async
                      {
                     await postRegister(
                       nameController.text,
                       profesiController.text,
                       emailController.text,
                      passwordController.text)
                      .then((value) => {
                        if (value != null){
                       setState(() {
                         Navigator.pop(context);
                         Flushbar(
                           message: "Berhasil Registrasi ",
                           duration: Duration(seconds: 2),
                           backgroundColor: Colors.greenAccent,
                           flushbarPosition:FlushbarPosition.TOP,).show(context);
                   })
               }
               else if (value == null)
               {
                 Flushbar(
                   message:"Check Your Field Before Register",
                  duration: Duration(seconds: 5),
                  backgroundColor: Colors.redAccent,
                  flushbarPosition:
                  FlushbarPosition.TOP,).show(context)
                      

               }
                      });
                      },
                      child: Text("Daftar")
                  
                   )
                   ) //akhir tahap 6
                ], // penutup childer tahap 1
              ),
            ),
          ),
        ),
      ),
    ); // akhir scaffold
  }
  }