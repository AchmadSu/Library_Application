// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_application/colors.dart';
import 'package:library_application/routes.dart';
import 'package:library_application/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import './custom_animation.dart';
// import 'package:http/http.dart';

// import 'package:library_application/helperurl.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key:key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  // String url = Url().getUrlDevice();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = true;
  late Timer _timer;
  
  String username = "";
  String nameSession = "";
  String textUsercode = "";
  String textPassword = "";
  bool? logout;
  bool? _isChecked = false;

  void initState() {
    // checkLogout();
    checkSession();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..backgroundColor = unSelectedBar
      ..indicatorColor = magenta
      ..maskColor = magenta
      ..userInteractions = false;
    // EasyLoading.show(status: "Memuat...");
    // EasyLoading.dismiss();
    super.initState();
    FlutterNativeSplash.remove();
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: bgMain,
              padding: const EdgeInsets.all(10),
              width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  CircularProgressIndicator(
                    color: redButton,
                  ),
                  Text(
                    "Proses Masuk \nSedang Berlangsung...",
                    style: TextStyle(
                      color: magenta,
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
    new Future.delayed(new Duration(seconds: 5), () {
      Navigator.pop(context); //pop dialog
      checkLogin();
    });
  }

  // void _onPageLoading() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10.0),
  //           child: Container(
  //             color: bgMain,
  //             padding: const EdgeInsets.all(10),
  //             width: 130,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               mainAxisSize: MainAxisSize.max,
  //               children: const [
  //                 CircularProgressIndicator(
  //                   color: redButton,
  //                 ),
  //                 Text(
  //                   "Halaman Sedang dimuat \nMohon Tunggu...",
  //                   style: TextStyle(
  //                     color: magenta,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       );
  //     },
  //   );
  // }

  void pageRoute(String id, String username, String email, String phone, String info, String picture) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('user_id', id);
    await pref.setString('user_name', username);
    await pref.setString('user_email', email);
    await pref.setString('user_phone', phone);
    await pref.setString('user_info', info);
    await pref.setString('user_picture', picture);
    pref.commit();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => Dashboard(userId: id)));
  }

  void checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String?val = pref.getString("user_id");
    print("val: $val");
    if(val != null) {
      // EasyLoading.show(status: "Memuat ...");
      username = pref.getString("user_name")!;
      EasyLoading.showSuccess("Anda masuk sebagai \n$username");
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard(userId: val)));
      EasyLoading.dismiss();
    }
    else
    {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("user_id");
      await pref.clear();
    }
  }

  void checkLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    logout =  pref.getBool("logout")!;
  }

  void checkLogin() async {
    var dataLogin = await http.post(
      Uri.parse("http://192.168.0.8/library_application/index.php/login/checkLogin/"), 
      body: {"user_code" : textUsercode, "user_password" : textPassword});
     
    var sessionArray =  jsonDecode(dataLogin.body);
    // print(sessionArray);
    // nameSession = sessionArray['user_name'];

    if(sessionArray != null){
      nameSession = sessionArray['user_name'];
      // print(sessionArray);
      EasyLoading.showSuccess("Anda berhasil masuk sebagai $nameSession!");
      pageRoute(sessionArray['user_id'], sessionArray['user_name'], sessionArray['user_email'], sessionArray['user_phone'], sessionArray['user_info'], sessionArray['user_picture']);
    } 
    else 
    {
      EasyLoading.showError("Email/Username dan atau Password anda salah!");
    }
  }

  // Future<bool> _onWillPop() => Future.value(false);

  @override
  Widget build(BuildContext context) {
    // EasyLoading.showSuccess("Berhasil dimuat!");
    // _onWillPop();
    return WillPopScope(
      onWillPop: () async => false,    
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Library Application"),
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          foregroundColor: redButton,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: redButton
              ),
              onPressed: () {},
              child: const Icon(Icons.info_outline),
            ),
          ],
        ),
        body: 
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 2),
                child: const Text(
                  "Library Application",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.black54
                  ),  
                )
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(15, 2, 15, 15),
                child: const Text(
                  "Mulai harimu dengan membaca buku sekarang!",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    // fontWeight: FontWeight.bold,
                    color: Colors.black54
                  ),  
                )
              ),
              Container(
                alignment: Alignment.center,
                // padding: const EdgeInsets.all(10),
                child: (
                  Image.asset(
                    'assets/img/5234.jpg',
                    // height: 100,
                    // width: 200,
                  )
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.black54
                  ),  
                )
              ),
              Container(
                width : MediaQuery.of(context).size.width * 0.5,
                height: 100,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: TextField(
                  autofocus: false,
                  onChanged: (x) => textUsercode = x,
                  controller: nameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: bgTextfield,
                    // border: OutlineInputBorder(),
                    labelText: 'Email/Username',
                    focusColor: bgWhite,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: redButton),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: redButton)
                    ),
                    prefixIcon: (Icon(FontAwesomeIcons.key)),
                  ),
                  style: const TextStyle(
                    color: bgMain,
                    fontFamily: 'Montserrat',
                  ),  
                )
              ),
              Container(
                width : MediaQuery.of(context).size.width * 0.5,
                height: 100,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: TextField(
                  autofocus: false,
                  onChanged: (x) => textPassword = x,
                  controller: passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: bgTextfield,
                    // border: OutlineInputBorder(),
                    labelText: 'Password',
                    focusColor: bgWhite,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: redButton),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: redButton)
                    ),
                    prefixIcon: (Icon(FontAwesomeIcons.lock)),
                  ),
                  style: const TextStyle(
                    color: bgMain,
                    fontFamily: 'Montserrat',
                  ),  
                )
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      textUsercode = textUsercode;
                      textPassword = textPassword;
                    });
                    if(textUsercode == "" || textPassword == ""){
                      Fluttertoast.showToast(
                        msg: "Username atau Email atau Password kosong. Anda harus mengisi untuk masuk!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        backgroundColor: redButton,
                        textColor: textWhite,
                        fontSize: 16.0
                      );
                      
                    }
                    else{
                      _onLoading();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    height: 60.0,//MediaQuery.of(context).size.width * .08,
                    width: 220.0,//MediaQuery.of(context).size.width * .3,
                    decoration: const BoxDecoration(
                      color: redButton,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 233, 233, 233),
                          blurRadius: 4,
                          offset: Offset(8, 8)
                        )
                      ]
                    ),
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          print(constraints);
                          return Container(
                            height: constraints.maxHeight,
                            width: constraints.maxHeight,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10)
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_circle_right,
                              color: redButton,
                            ),
                          );
                        }),
                      ]
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Lupa Password?',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                // margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: const Text(
                  'ATAU',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(221, 131, 131, 131)
                  ),
                ),
              ),
              Container(
                height: 50,
                // margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 60.0,//MediaQuery.of(context).size.width * .08,
                    width: 220.0,//MediaQuery.of(context).size.width * .3,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(245, 245, 245, 245),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child:
                            Image.asset(
                              'assets/img/2.png',
                            )
                        ),
                        const Expanded(
                          child: Text(
                            'Login dengan Google',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 75, 75, 75)
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "New Member? ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    TextButton(
                      onPressed:(){

                      },
                      child: const Text(
                        'Register here',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    )
                  ],
                ) 
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Ecep Achmad Sutisna \u00a9 2022",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 12,
                    color: Color.fromARGB(221, 179, 179, 179)
                  ),
                ),
              )
            ]
          )
        )
      ),
    );
  }
}