import 'package:flutter/foundation.dart';

class Images {
  static final CoverBooks = <CoverBook>[
    CoverBook(
      urlFront: 'assets/1_front.png',
    ),
    CoverBook(
      urlFront: 'assets/2_front.png',
    ),
    CoverBook(
      urlFront: 'assets/3_front.png',
    ),
  ];

  static final frontCoverBooks =
      Images.CoverBooks.map((card) => card.urlFront).toList();
}

class CoverBook {
  final String urlFront;
  // final String urlBack;

  const CoverBook({
    required this.urlFront,
  });
}