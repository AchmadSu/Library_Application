// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

List<BookModel> bookModelFromJson(String str) => List<BookModel>.from(json.decode(str).map((x) => BookModel.fromJson(x)));

String bookModelToJson(List<BookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EntryBook {
  String entryTitle;
  String entryAuthor;
  String entryYear;
  String entryPicture;
  String entryPublisher;
  String entryCategory;

  EntryBook({
    required this.entryTitle,
    required this.entryAuthor,
    required this.entryYear,
    required this.entryPicture,
    required this.entryPublisher,
    required this.entryCategory,
  });
} 


class BookModel {
    BookModel({
        required this.bookId,
        required this.bookTitle,
        required this.bookAuthor,
        required this.bookYear,
        required this.bookPublisher,
        required this.bookImage,
        required this.bookCategory,
    });

    final String bookId;
    final String bookTitle;
    final String bookAuthor;
    final String bookYear;
    final String bookPublisher;
    final String bookImage;
    final String bookCategory;

    factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        bookId: json["book_id"],
        bookTitle: json["book_title"],
        bookAuthor: json["book_author"],
        bookYear: json["book_year"],
        bookPublisher: json["book_publisher"],
        bookImage: json["book_image"],
        bookCategory: json["book_category"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "book_title": bookTitle,
        "book_author": bookAuthor,
        "book_year": bookYear,
        "book_publisher": bookPublisher,
        "book_image": bookImage,
        "book_category": bookCategory,
    };
}