import 'dart:convert';
import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_application/model/model.dart';
import 'package:library_application/model/shortcut.dart';
import 'package:library_application/model/newBook.dart';
import 'package:library_application/model/bookModel.dart';
import 'package:library_application/view/profile.dart';
import 'package:library_application/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_application/colors.dart';
// import 'package:library_application/controller/controller.dart';
import 'package:library_application/images.dart';
import 'package:library_application/routes.dart';
import 'package:library_application/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:library_application/controller/controller.dart';
// import 'globals.dart' as globals;

// int bookId = 0;

class UpdateData extends StatefulWidget {
  final int id;
  UpdateData({Key? key, required this.id}) : super(key: key);
  @override
  State<UpdateData> createState() => UpdateDataState();
}

class UpdateDataState extends State<UpdateData> {
  @override
  void initState() {
    checkSession();
    getDataLogin();
    if (picture == "") {
      picture = "user.png";
    }
    super.initState();
    setState(() {
      bookId = widget.id;
      print("id : $bookId");
      getDataBookById(bookId);
      // selectedBook;
    });
  }

  Future checkBook(List listBook) async {
    Map data = listBook[_counter];
    setState(() {
      _counter++;
    });
    // print(data);
    try
    {
      http.Response checkData = await http.post(
      Uri.parse("http://192.168.0.8/library_application/index.php/books/checkDataBook/"), 
      body: json.encode(data));
      var dataArray = jsonDecode(checkData.body);
      // print(dataArray);
      if(dataArray != null){
        Fluttertoast.showToast(
          msg: "Data sudah ada! Silakan isi data yang lain",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: redButton,
          textColor: textWhite,
          fontSize: 16.0
        );
        entryBook.removeAt(_counter);
      }
      else {
        await http.post(
          Uri.parse("http://192.168.0.8/library_application/index.php/books/updateBook/$bookId"), 
          body: json.encode(data));
        Fluttertoast.showToast(
          msg: "Data berhasil diubah! Silakan check Beranda untuk melihat data yang anda masukkan!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: blueText,
          textColor: textWhite,
          fontSize: 16.0
        );
        entryBook.removeAt(_counter);
        setState(() {
          _bookTitleController.clear();
          _bookAuthorController.clear();
          _bookYearController.clear();
          _bookImageController.clear();
        });
      }

    } catch (e) {
      print(e);
    }
  }

  void setPublisher(String publisher){
    setState(() {
      bookPublisher = publisher;
    });
  }

  void setCategory(String category){
    setState(() {
      bookPublisher = category;
    });
  }

  void checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String?val = pref.getString("user_id");
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
    // // ignore: deprecated_member_use
    // pref.commit();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfilePage(userId: id)));
  }

  void pageRouteDashboard(String id) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('user_id', id);
    // await pref.setString('user_name', username);
    // await pref.setString('user_email', email);
    // await pref.setString('user_phone', phone);
    // await pref.setString('user_info', info);
    // await pref.setString('user_picture', picture);
    // // ignore: deprecated_member_use
    // pref.commit();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => Dashboard(userId: id)));
  }

  // checkBook(entryBook);
  Future checkUrlImage(String url) async {
    try
    {
      http.Response checkImage = await http.get(
        Uri.parse(url)
      );
      // print(checkImage.statusCode);
      if(checkImage.statusCode == 200){
        entryBook.add({"book_title" : textBookTitle, "book_author" : textBookAuthor, "book_year": textBookYear, "book_publisher": bookPublisher, "book_image": textBookPicture, "book_category": bookCategory});
        checkBook(entryBook);
      }

    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error : $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: redButton,
        textColor: textWhite,
        fontSize: 16.0
      );
    }
  }

  void getDataBookById(int id) async {
    // print(id);
    var dataBook = await http.get(
      Uri.parse("http://192.168.0.8/library_application/index.php/books/getBookById/$id"),
    headers: {"Accept": "application/json"});
    // print(result);
    setState(() {
      selectedBook.addAll(jsonDecode(dataBook.body));
        // itemSelectedBook.add(
        //   {
        //     "book_title" : selectedBook['book_title'], 
        //     "book_author" : selectedBook['book_author'], 
        //     "book_year": selectedBook['book_year'], 
        //     "book_publisher": selectedBook['book_publisher'], 
        //     "book_image": selectedBook['book_image'], 
        //     "book_category": selectedBook['book_category']
        //   }
        // );
      // _bookTitleController = selectedBook['book_title']!;
      // _bookAuthorController = selectedBook['book_author']!;
      // _bookYearController = selectedBook['book_year']!;
      // _bookImageController = selectedBook['book_publisher']!;

      // textBookTitle = selectedBook['book_title']!;
      // textBookAuthor = selectedBook['book_author']!;
      // textBookYear = selectedBook['book_year'];
      _title = selectedBook['book_title'];
      _author = selectedBook['book_author'];
      _year = selectedBook['book_year'];
      _picture = selectedBook['book_image'];
      print("print: $_picture");
      bookPublisher = selectedBook['book_publisher'].toString();
      bookCategory = selectedBook['book_category'].toString();
    });
  }

  TextEditingController _bookTitleController = TextEditingController();
  TextEditingController _bookAuthorController = TextEditingController();
  TextEditingController _bookYearController = TextEditingController();
  TextEditingController _bookImageController = TextEditingController();
  TextEditingController bookPublisherController = TextEditingController();
  TextEditingController bookCategoryController = TextEditingController();

  bool _isLoading = true;
  late Timer _timer;
  String username = "";
  String nameSession = "";
  String textPassword = "";
  String userId = "";
  String email = "";
  String phone = "";
  String info = "";
  String picture = "";
  int bookId = 0;
  String title = "";
  String textBookTitle = "";
  String textBookAuthor = "";
  String textBookYear = "";
  String textBookPicture = "";
  String bookPublisher = "";
  String bookCategory = "";
  String _title = "";
  String _author = "";
  String _year = "";
  String _picture = "https://agentestudio.com/uploads/post/image/69/main_how_to_design_404_page.png";
  String urlImage = "";
  int _counter = 0;
  File? image;

  List<Map<String, String>> entryBook = [];
  Map<String, dynamic> selectedBook = {};
  List <Map<String, String>> itemSelectedBook = [];
  
  @override
  Widget build(BuildContext context){
    // bookId = widget.id;
    // print(bookId);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Library Apps"),
        toolbarHeight: 70,
        backgroundColor: bgMain,
        foregroundColor: redButton,
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
      resizeToAvoidBottomInset: true,
      backgroundColor: bgMain,
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 20000, minHeight: 3000),
        child: ListView(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      "Edit Data Buku $_title",
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: textWhite
                      ),  
                    )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 600,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width*0.40,
                      padding: EdgeInsets.all(12.0),
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                            _picture,
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width : MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 30),
                    // Icon(FontAwesomeIcons.cartPlus),
                    child: TextField(
                      autofocus: false,
                      onChanged: (x) => textBookTitle = x,
                      controller: _bookTitleController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: bgTextfield,
                        // border: OutlineInputBorder(),
                        labelText: 'Masukkan judul buku',
                        focusColor: bgWhite,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redButton),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButton)
                        ),
                        prefixIcon: (Icon(FontAwesomeIcons.book)),
                      ),
                      style: const TextStyle(
                        color: textWhite,
                        fontFamily: 'Montserrat',
                      ),  
                    )
                  ),
                ],
              )  
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width : MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                    // Icon(FontAwesomeIcons.cartPlus),
                    child: TextField(
                      autofocus: false,
                      onChanged: (x) => textBookAuthor = x,
                      controller: _bookAuthorController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: bgTextfield,
                        // border: OutlineInputBorder(),
                        labelText: 'Masukkan penulis buku',
                        focusColor: bgWhite,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redButton),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButton)
                        ),
                        prefixIcon: (Icon(FontAwesomeIcons.userPen)),
                      ),
                      style: const TextStyle(
                        color: textWhite,
                        fontFamily: 'Montserrat',
                      ),  
                    )
                  ),
                ],
              )  
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width : MediaQuery.of(context).size.width * 0.5,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                    // Icon(FontAwesomeIcons.cartPlus),
                    child: TextField(
                      autofocus: false,
                      onChanged: (x) => textBookYear = x,
                      controller: _bookYearController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: bgTextfield,
                        // border: OutlineInputBorder(),
                        labelText: 'Tahun buku',
                        focusColor: bgWhite,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redButton),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButton)
                        ),
                        prefixIcon: (Icon(FontAwesomeIcons.solidCalendarDays)),
                      ),
                      style: const TextStyle(
                        color: textWhite,
                        fontFamily: 'Montserrat',
                      ),  
                    )
                  ),
                  
                Container(
                  width : MediaQuery.of(context).size.width * 0.5,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  // Icon(FontAwesomeIcons.cartPlus),
                  // color: bgTextfield,
                  child: DropdownButtonFormField(
                    // dropdownColor: redButton,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: redButton),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: redButton)
                      ),
                      hoverColor: magenta,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0), 
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: magenta),
                        focusColor: magenta,
                        fillColor: bgTextfield),
                      hint: Text(
                        bookPublisher,
                        style: const TextStyle(
                            color: textWhite,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      // value: bookPublisher,
                      items: <String>['Gramedia', 'Erlangga'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          bookPublisher = value.toString();
                          // setPublisher(bookPublisher);
                          // print(bookPublisher);
                        });
                      },
                      autofocus: false,
                    ), 
                  )
                ],
              )  
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width : MediaQuery.of(context).size.width * 0.5,
                    height: 100,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                    child: TextField(
                      autofocus: false,
                      onChanged: (x) => textBookPicture = x,
                      controller: _bookImageController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: bgTextfield,
                        // border: OutlineInputBorder(),
                        labelText: 'Link Gambar',
                        focusColor: bgWhite,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redButton),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButton)
                        ),
                        prefixIcon: (Icon(FontAwesomeIcons.image)),
                      ),
                      style: const TextStyle(
                        color: textWhite,
                        fontFamily: 'Montserrat',
                      ),  
                    )
                  ),  
                  Container(
                    width : MediaQuery.of(context).size.width * 0.5,
                    height: 100,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                    // Icon(FontAwesomeIcons.cartPlus),
                    // color: bgTextfield,
                    child: DropdownButtonFormField(
                      // dropdownColor: redButton,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redButton),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButton)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0), 
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: magenta),
                          fillColor: bgTextfield),
                        hint: Text(
                          bookCategory,
                          style: const TextStyle(
                              color: textWhite,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        // value: bookPublisher,
                        items: <String>['Recommend', 'New'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            bookCategory = value.toString();
                            // setCategory(bookCategory);
                          });
                        },
                        autofocus: false,
                      ), 
                    ),
                ],
              ),  
            ),
            TextButton(
              onPressed: (){
                if(textBookAuthor == "" || textBookPicture == "" || textBookTitle == "" || textBookYear == "" || bookCategory == "" || bookPublisher == ""){
                  Fluttertoast.showToast(
                    msg: "Terdapat data yang kosong. Isi semua data dengan benar!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: redButton,
                    textColor: textWhite,
                    fontSize: 16.0
                  );
                }
                else{
                  checkUrlImage(textBookPicture);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
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
                            FontAwesomeIcons.check,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: const Text(
                            'Simpan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ) 
            ),
          ],
        ),
      )
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: FloatingActionButton(
      //     onPressed: () {
            
      //     },
      //     child: const Icon(Icons.add, color:textWhite, size: 29,),
      //     backgroundColor: redButton,
      //     tooltip: 'Tambah Buku',
      //     elevation: 5,
      //     splashColor: Colors.grey,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}