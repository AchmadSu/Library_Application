// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_application/model/model.dart';
import 'package:library_application/model/shortcut.dart';
import 'package:library_application/model/newBook.dart';
import 'package:library_application/model/bookModel.dart';
import 'package:library_application/view/profile.dart';
import 'package:library_application/view/insertData.dart';
import 'package:library_application/view/login.dart';
import 'package:library_application/view/updateData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_application/colors.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:library_application/controller/controller.dart';
import 'package:library_application/images.dart';
import 'package:library_application/routes.dart';
import 'package:library_application/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:library_application/controller/controller.dart';
// import 'globals.dart' as globals;

class Dashboard extends StatefulWidget {
  final String userId;

  const Dashboard({Key? key, required this.userId}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController nameController = TextEditingController();

  // String sessionId = "";
  String userId = "";
  String username = "";
  String email = "";
  String phone = "";
  String info = "";
  String picture = "";
  String textUsercode = "";
  String itemImage = "";
  String imageText = "";
  String bookId = "";
  String bookTitle = "";
  String bookAuthor = "";
  String bookYear = "";
  String bookPublisher = "";
  int _counter = 0;
  // String bookId = "";

  @override
  void initState() {
    checkSession(widget.userId);
    getDataLogin();
    if (picture == "") {
      picture = "user.png";
    }
    super.initState();
    // countAllBooks();
    getRecommendBooks();
    getNewBooks();
    FlutterNativeSplash.remove();
    // itemDetail.removeAt(_counter);
  }
  
  List dataImage = [];

  int result = 0;

  List<Shortcut> shortcut = [
    Shortcut(
      shortcutName : 'Buku Favorite',
      shortcutIcon : 
        const Icon(
          Icons.favorite,
          color: Colors.pinkAccent,
          size: 60,
          semanticLabel: 'Favorite',
        ),
    ),
    Shortcut(
      shortcutName : 'Riwayat Peminjaman',
      shortcutIcon : 
        const Icon(
          Icons.history,
          color: unSelectedBar,
          size: 60,
          semanticLabel: 'History',
        ),
    ),
    Shortcut(
      shortcutName : 'Deadline',
      shortcutIcon : 
        const Icon(
          Icons.today_rounded,
          color: blueText,
          size: 60,
          semanticLabel: 'Overdue',
        ),
    ),
    Shortcut(
      shortcutName : 'Denda',
      shortcutIcon : 
        const Icon(
          Icons.monetization_on_rounded,
          color: redButton,
          size: 60,
          semanticLabel: 'Cost',
        ),
    ),
    Shortcut(
      shortcutName : 'Pengaturan',
      shortcutIcon : 
        const Icon(
          Icons.settings,
          color: textSetting,
          size: 60,
          semanticLabel: 'Settings',
        ),
    ),
  ];

  List <dynamic> urlImage = [];
  List <dynamic> itemRecommend = [];
  List <dynamic> itemDetail = [];
  List <dynamic> itemNew = [];

  int index = 0;

  void getRecommendBooks() async {
    var dataBook = await http.get(
      Uri.parse("http://192.168.0.8/library_application/index.php/books/getBooksByCategory/Recommend"),
      headers: {"Accept": "application/json"});
      print(result);
        setState(() {
            itemRecommend.addAll(jsonDecode(dataBook.body)); 
        });
  }
  
  void getNewBooks() async {
    var dataBook = await http.get(
      Uri.parse("http://192.168.0.8/library_application/index.php/books/getBooksByCategory/New"),
      headers: {"Accept": "application/json"});
      print(result);
        setState(() {
            itemNew.addAll(jsonDecode(dataBook.body)); 
        });
  }

  void checkSession(String sessionId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String?val = sessionId;
    print("val: $val");
    if(val == null) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
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

  void pageRouteProfile(String id) {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('user_id', id);
    // await pref.setString('user_name', username);
    // await pref.setString('user_email', email);
    // await pref.setString('user_phone', phone);
    // await pref.setString('user_info', info);
    // await pref.setString('user_picture', picture);
    // pref.commit();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfilePage(userId: id)));
  }

  deleteBook(String id) async {
    try
    {
      http.Response deleteData = await http.post(
      Uri.parse("http://192.168.0.8/library_application/index.php/books/delete/$id"));
      // var dataArray = jsonDecode(checkData.body);
      // print(dataArray);
      if(deleteData.statusCode == 200){
        Fluttertoast.showToast(
          msg: "Data berhasil dihapus!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: redButton,
          textColor: textWhite,
          fontSize: 16.0
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error! Msg: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: blueText,
        textColor: textWhite,
        fontSize: 16.0
      );
    }
  }

  void pageRouteInsertData(String id){
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('user_id', id);
    // await pref.setString('user_name', username);
    // await pref.setString('user_email', email);
    // await pref.setString('user_phone', phone);
    // await pref.setString('user_info', info);
    // await pref.setString('user_picture', picture);
    // pref.commit();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => InsertData(userId : id)));
  }

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
      context, MaterialPageRoute(builder: (context) => const Dashboard(userId: "Dashboard")));
  }

  void showDetail(String id) async {
    var dataBook = await http.get(
      Uri.parse("http://192.168.0.8/library_application/index.php/books/getBookById/$id"),
      headers: {"Accept": "application/json"});
      itemDetail.add(jsonDecode(dataBook.body)); 
      // print(itemDetail);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          backgroundColor: textWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration (
                  // color: redButton,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget> [
                    Icon(
                      FontAwesomeIcons.infoCircle,
                      color: blueText,
                    ),
                    Text(
                      "  Detail Buku",
                      style: TextStyle(
                        color: blueText,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]
                )
              )
            ),
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.35,
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                              itemDetail[_counter]['book_image'],
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              height: 200,
                              width: 1000,
                              fit: BoxFit.cover,
                            ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: 300,
                        child: Column(
                          children: [
                            SimpleDialogOption(
                              onPressed: (){
                                // Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.025,
                                    child: const Icon(
                                      FontAwesomeIcons.book,
                                      color: textSetting,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.225,
                                    padding: EdgeInsets.symmetric(horizontal: 12.5),
                                    child: Text(
                                      itemDetail[_counter]['book_title'],
                                      style: const TextStyle(
                                        color: textSetting,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]
                              )
                            ),
                            SimpleDialogOption(
                              onPressed: (){
                                // Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.025,
                                    child: const Icon(
                                      FontAwesomeIcons.userPen,
                                      color: textSetting,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.225,
                                    padding: EdgeInsets.symmetric(horizontal: 12.5),
                                    child: Text(
                                      itemDetail[_counter]['book_author'],
                                      style: const TextStyle(
                                        color: textSetting,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: (){
                                // Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.025,
                                    child: const Icon(
                                      FontAwesomeIcons.globe,
                                      color: textSetting,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.225,
                                    padding: EdgeInsets.symmetric(horizontal: 12.5),
                                    child: Text(
                                      itemDetail[_counter]['book_publisher'],
                                      style: const TextStyle(
                                        color: textSetting,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: (){
                                // Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.025,
                                    child: const Icon(
                                      FontAwesomeIcons.calendarDays,
                                      color: textSetting,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.225,
                                    padding: EdgeInsets.symmetric(horizontal: 12.5),
                                    child: Text(
                                      itemDetail[_counter]['book_year'],
                                      style: const TextStyle(
                                        color: textSetting,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: (){
                        itemDetail.removeAt(_counter);
                        Navigator.pop(context);
                      },
                      child: FittedBox(
                        // constraints: const BoxConstraints(maxWidth: fit),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.35,
                          decoration: BoxDecoration (
                            color: unSelectedBar,
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
                                  'Tutup',
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
                      onPressed: (){
                        // itemDetail.removeAt(_counter);
                        var myInt = int.parse(id);
                        assert(myInt is int);
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => UpdateData(id : myInt)));
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
                                  FontAwesomeIcons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Text(
                                  'Edit',
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

  void deleteConfirm(String id){
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget> [
                  Icon(
                    FontAwesomeIcons.warning,
                    color: textWhite,
                  ),
                  Text(
                    "Konfirmasi Penghapusan",
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
                    "Apakah anda yakin akan menghapus data terpilih?",
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
                      onPressed: (){
                        // itemDetail.removeAt(_counter);
                        deleteBook(id);
                        pageRoute(userId, username, email, phone, info, picture);
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
                                  FontAwesomeIcons.trash,
                                  color: textWhite,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Text(
                                  'Hapus',
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

  @override
  Widget build(BuildContext context) {
    // itemDetail.removeAt(_counter);
    print(result);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Library Apps"),
        toolbarHeight: 70,
        backgroundColor: bgMain,
        foregroundColor: redButton,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: redButton
            ),
            onPressed: () {},
            child: const Icon(
              FontAwesomeIcons.solidBookmark
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: bgMain,
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 10000, minHeight: 3000),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                Container(
                  margin: EdgeInsets.fromLTRB(2, 10, 2, 2),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: textWhite,
                    radius: 52.5,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                      'assets/img/$picture',
                      ),
                    radius: 50,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  child: const Icon(
                    FontAwesomeIcons.solidBell,
                    color: textWhite,
                    size: 20,
                  )  
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: Text(
                "Halo $username!",
                style: const TextStyle(
                  fontSize: 18.5,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: textWhite
                ),  
              )
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              // Icon(FontAwesomeIcons.cartPlus),
              child: TextField(
                autofocus: false,
                onChanged: (x) => textUsercode = x,
                controller: nameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: bgTextfield,
                  // border: OutlineInputBorder(),
                  labelText: 'Ketik pencarian buku',
                  focusColor: bgWhite,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: redButton),
                    
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: redButton)
                  )
                ),
                style: const TextStyle(
                  color: textWhite,
                  fontFamily: 'Montserrat',
                ),  
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                  child: const Text(
                    "Top Rekomendasi \nuntuk anda!",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: textWhite
                    ),  
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                  child: InkWell(
                    onTap: (){},
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Raleway',
                        color: bgTextLink,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(0),
              child: CarouselSlider(
                options: CarouselOptions(
                  // height: 400.0,
                  viewportFraction: 0.3,
                  enableInfiniteScroll: false,
                  disableCenter: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16/9,
                  scrollDirection: Axis.horizontal,
                ),
                items: itemRecommend.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 7.0),
                        child: ClipRRect( 
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: (){
                              Fluttertoast.showToast(
                                msg: "Ketuk 2 kali untuk melihat detail. Tahan lama untuk menghapus.",
                                toastLength: Toast.LENGTH_LONG,
                                // timeInSecForIosWeb: 12,
                                gravity: ToastGravity.TOP,
                                backgroundColor: textWhite,
                                textColor: bgMain,
                                fontSize: 16.0
                              );
                            },
                            onDoubleTap: (){
                              showDetail(i['book_id']);
                            },
                            onLongPress: (){
                              deleteConfirm(i['book_id']);
                            },
                            child: Image.network(
                              i['book_image'],
                              height: 150.0,
                              width: 1000.0,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          )
                        )
                      );
                    },
                  );
                }).toList(),
              )
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              child: InkWell(
                onTap: (){},
                child: const Text(
                  'Quick Access',
                    style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: textWhite
                  ),
                ),
              )
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 130,
                  viewportFraction: 0.4,
                  enableInfiniteScroll: false,
                  disableCenter: true,
                  // enlargeCenterPage: true,
                  aspectRatio: 2.6,
                  scrollDirection: Axis.horizontal,
                ),
                items:
                  shortcut.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Card(
                                color: magenta,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: (
                                        i.shortcutIcon
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  i.shortcutName,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      );
                    },
                  );
                }).toList(),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: const Text(
                    "Daftar Buku Baru",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: textWhite
                    ),  
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: InkWell(
                    onTap: (){},
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Raleway',
                        color: bgTextLink,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 320.0,
                  viewportFraction: 0.4,
                  enableInfiniteScroll: false,
                  disableCenter: true,
                  // enlargeCenterPage: true,
                  aspectRatio: 2.6,
                  scrollDirection: Axis.horizontal,
                ),
                items: itemNew.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: InkWell(
                          onTap: (){
                            Fluttertoast.showToast(
                              msg: "Ketuk 2 kali untuk melihat detail. Tahan lama untuk menghapus.",
                              toastLength: Toast.LENGTH_LONG,
                              // timeInSecForIosWeb: 12,
                              gravity: ToastGravity.TOP,
                              backgroundColor: textWhite,
                              textColor: bgMain,
                              fontSize: 16.0
                            );
                          },
                          onDoubleTap: (){
                            showDetail(i['book_id']);
                          },
                          onLongPress: (){
                            deleteConfirm(i['book_id']);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                    i['book_image'],
                                    loadingBuilder: (BuildContext context, Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    height: 200,
                                    width: 1000,
                                    fit: BoxFit.cover,
                                  ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                      child: Text(
                                        i['book_title'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    },
                  );
                }).toList(),
              )
            ),
          ],
          // itemCount: item == null ? 0 : item.length,
          shrinkWrap: true,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap : (int index) {
          // print(index);
          if (index == 1) {
            pageRouteInsertData(userId);
          }
          else if (index == 2) {
            pageRouteProfile(userId);
          }
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}