// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_application/main.dart';
import 'package:library_application/model/model.dart';
import 'package:library_application/model/shortcut.dart';
import 'package:library_application/model/newBook.dart';
import 'package:library_application/view/login.dart';
import 'package:library_application/view/profile.dart';
import 'package:library_application/view/insertData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_application/colors.dart';
import 'package:library_application/images.dart';
import 'package:library_application/routes.dart';
import 'package:library_application/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget{
  final String userId;
  const ProfilePage({Key? key, required this.userId}) : super(key:key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String userId = "";
  String username = "";
  String email = "";
  String phone = "";
  String info = "";
  String picture = "";
  String textUsercode = "";
  String logout = "0";

  void initState() {
    checkSession(widget.userId);
    EasyLoading.show(status: "Memuat ...");
    super.initState();
    getDataLogin();
    if (picture == "") {
      picture = "user.png";
    }
    EasyLoading.dismiss();
  }

  void getDataLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString("user_id")!;
      username = pref.getString("user_name")!;
      email = pref.getString("user_email")!;
      phone = pref.getString("user_phone")!;
      info = pref.getString("user_info")!;
      picture = pref.getString("user_picture")!;
    });
  }

  void pageRouteDashboard(String id) {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('user_id', id);
    // await pref.setString('user_name', username);
    // await pref.setString('user_email', email);
    // await pref.setString('user_phone', phone);
    // await pref.setString('user_info', info);
    // await pref.setString('user_picture', picture);
    // pref.commit();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => Dashboard(userId: id)));
  }

  void pageRouteInsertData(String id) {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('user_id', id);
    // await pref.setString('user_name', username);
    // await pref.setString('user_email', email);
    // await pref.setString('user_phone', phone);
    // await pref.setString('user_info', info);
    // await pref.setString('user_picture', picture);
    // pref.commit();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => InsertData(userId: id)));
  }

  void checkSession(String sessionId){
    // SharedPreferences pref = await SharedPreferences.getInstance();
    String?val = sessionId;
    if(val == null) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  void exitConfirm(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Center(
            child: Container(
              // color: Colors.white,
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration (
                  color: redButton,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const <Widget> [
                  Icon(
                    FontAwesomeIcons.warning,
                    color: textWhite,
                  ),
                  Text(
                    "Konfirmasi Keluar",
                    style: TextStyle(
                      color: textWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              )
            )
          ),
          children: [
            Column(
              children: [
                Container(
                  // alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(30.0),
                  child: const Text(
                    "Apakah anda yakin akan keluar?",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: textWhite
                    ),  
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: (){
                        // itemDetail.removeAt(_counter);
                        Navigator.pop(context);
                      },
                      child: FittedBox(
                        // constraints: const BoxConstraints(maxWidth: fit),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.35,
                          decoration: BoxDecoration (
                            color: blueText,
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Icon(
                                  FontAwesomeIcons.close,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Text(
                                  'Batal',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ) 
                    ),
                    TextButton(
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        // String test = pref.getString("user_id")!;
                        // Logs.debug("checking for  key : $key");
                        await pref.clear();
                        // print();
                        // await pref.remove(test);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                      child: FittedBox(
                        // constraints: const BoxConstraints(maxWidth: fit),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.35,
                          decoration: BoxDecoration (
                            color: redButton,
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Icon(
                                  Icons.logout_outlined,
                                  color: textWhite,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ) 
                    ),
                  ],
                )
              ],
            ),
          ], 
        );
      } 
    );
  }

  void checkEducation(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration (
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget> [
                  Icon(
                    FontAwesomeIcons.school,
                    color: Colors.white,
                  ),
                  Text(
                    "  Educational History",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              )
            )
          ),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Image.asset(
                'assets/img/6.jpg',
                // height: 100,
                // fit: BoxFit.cover,
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Politeknik TEDC Bandung',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'SMK Insan Mandiri',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'SMP Negeri 26 Bandung',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'SD Yayasan Amal Keluarga',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
          ], 
        );
      } 
    );
  }

  void checkOrganization(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration (
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget> [
                  Icon(
                    FontAwesomeIcons.peopleGroup,
                    color: Colors.white,
                  ),
                  Text(
                    "  Organization \nExperience",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              )
            )
          ),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Image.asset(
                'assets/img/8.jpg',
                // height: 100,
                // fit: BoxFit.cover,
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Member of Organisasi Intra Sekolah SMK Insan Mandiri',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Leader of Muda Mahardika Unit 13',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Member of Relawan Covid Cigugurgirang',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Member of Muda Mahardika Cigugurgirang',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
          ], 
        );
      } 
    );
  }

  void checkWork(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration (
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget> [
                  Icon(
                    Icons.work,
                    color: Colors.white,
                  ),
                  Text(
                    "  Work Experience",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              )
            )
          ),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Image.asset(
                'assets/img/7.jpg',
                // height: 100,
                // fit: BoxFit.cover,
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Back Office of PT. Hardja Gunatama Lestari',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
          ], 
        );
      } 
    );
  }

  void checkHobbies(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration (
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget> [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  Text(
                    "  Hobbies",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              )
            )
          ),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Image.asset(
                'assets/img/9.jpg',
                // height: 100,
                // fit: BoxFit.cover,
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Futsal',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Graphic Designing',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                // Navigator.pop(context);
              },
              child: const Text(
                'Programming',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
            ),
          ], 
        );
      } 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Pengaturan Akun"),
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
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap:(){
                      pageRouteDashboard(userId);
                    },
                    child : Row(
                      children: <Widget> [
                        const Icon(
                          Icons.arrow_back,
                          color: textGrey,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: const Text(
                            "Kembali",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: textGrey
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  InkWell(
                    onTap:(){},
                    child : Row(
                      children: <Widget> [
                        const Icon(
                          Icons.edit,
                          color: textGrey,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: const Text(
                            "Ubah Profile",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: textGrey,
                            ),
                          ),
                        ),
                      ],
                    )
                  )  
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/img/$picture',
                  ),
                radius: 75,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              title: Center(
                child: Text(
                  username,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: unSelectedBar
                  ),
                ),
              ),
              subtitle: Center(
                child: Text(
                  info,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    color: Color.fromARGB(137, 146, 146, 146)
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.phone_android,
                    color: Color.fromARGB(135, 73, 73, 73)
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        // fontWeight: FontWeight.bold,
                        color: Color.fromARGB(135, 73, 73, 73)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.mail_outline,
                    color: Color.fromARGB(135, 73, 73, 73)
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        // fontWeight: FontWeight.bold,
                        color: Color.fromARGB(135, 73, 73, 73)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 3, color: Color.fromARGB(61, 158, 158, 158)
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 100,
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: blueText, width: 1),
                      shape: BoxShape.circle
                    ),
                    child: IconButton(
                      onPressed:() {},
                      icon: const Icon(FontAwesomeIcons.message),
                      color: blueText,
                    ),
                  ),
                  Container(
                    width: 100,
                    // padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: blueText,
                      border: Border.all(color: blueText, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: const[
                        BoxShadow(
                          color: blueText,
                          blurRadius: 4,
                          offset: Offset(0, 6), // Shadow position
                        ),
                      ],
                    ),
                    child: OutlinedButton(
                      child: const Text(
                        "Setting",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.transparent),
                        primary: blueText,
                        minimumSize: const Size(100, 50),
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: (){},
                    )
                  ),
                  Container(
                    width: 100,
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: blueText, width: 1),
                      shape: BoxShape.circle
                    ),
                    child: IconButton(
                      onPressed:() {},
                      icon: const Icon(FontAwesomeIcons.shareNodes),
                      color: blueText,
                    ),
                  )
                ],
              ),
            ),
            Container( 
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: InkWell(
                onTap: (){
                  checkEducation();
                },
                child:
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.school_outlined,
                        color: blueText,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          "Educational History",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),
                        ),
                      ),
                    ],
                  ),
                ) 
              )
            ),
            Container( 
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: InkWell(
                onTap: (){},
                child:
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.male,
                        color: blueText,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),
                        ),
                      ),
                    ],
                  ),
                ) 
              )
            ),
            Container( 
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: InkWell(
                onTap: (){
                  checkOrganization();
                },
                child:
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.people,
                        color: blueText,
                      ),
                        Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          "Organization Experience",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),
                        ),
                      ),
                    ],
                  ),
                ) 
              )
            ),
            Container( 
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: InkWell(
                onTap: (){
                  checkWork();
                },
                child:
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.work,
                        color: blueText,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          "Work Experience",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),
                        ),
                      ),
                    ],
                  ),
                ) 
              )
            ),
            Container( 
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 3, color: Color.fromARGB(61, 158, 158, 158)
                  )
                )
              ),
              child: InkWell(
                onTap: (){
                  checkHobbies();
                },
                child:
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.favorite_border_outlined,
                        color: blueText,
                      ),
                        Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          "Hobbies",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),
                        ),
                      ),
                    ],
                  ),
                ) 
              )
            ),
            Container( 
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: InkWell(
                onTap: () {
                  exitConfirm();
                },
                child:
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                        Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: redButton
                          ),
                        ),
                      ),
                    ],
                  ),
                ) 
              )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              alignment: Alignment.center,
              child: const Text(
                "Ecep Achmad Sutisna \u00a9 2022",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  color: Color.fromARGB(221, 77, 77, 77)
                ),
              ),
            )
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap : (int index) {
          if (index == 0)
            pageRouteDashboard(userId);
          else if (index == 1)
            pageRouteInsertData(userId);
        },
        selectedIconTheme: const IconThemeData(
          color: selectedBar,
        ),
        selectedItemColor: selectedBar,
        unselectedIconTheme: const IconThemeData(
          color: unSelectedBar,
        ),
        unselectedItemColor: unSelectedBar,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outlined),
            label: 'Tambah Buku',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
        currentIndex: 2,
        backgroundColor: bgMain,
      ),
    );
  }
}
