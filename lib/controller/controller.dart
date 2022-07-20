import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/bookModel.dart';

class Controller {
  Future getAllBooks() async {
    try {
      http.Response getBooks = await http.get(
      Uri.parse("http://192.168.100.63/library_application/index.php/books/getAllBooks/"), 
      headers: {"Accept": "application/json"});
      if (getBooks.statusCode == 200) {
        // print(hasil.body);
        final data = bookModelFromJson(getBooks.body);
        return data;
      } else {
        print("error status " + getBooks.statusCode.toString());
        return null;
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }
  }
}