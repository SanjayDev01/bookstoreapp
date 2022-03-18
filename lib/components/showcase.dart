import 'package:bookstoreapp/models/books.dart';
import 'package:flutter/material.dart';

class ShowCase extends StatelessWidget {
  const ShowCase({
    required this.wideImage,
    required this.bookObject,
  });

  final String wideImage;
  final Book bookObject;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => Details(bookObject)));
      },
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(wideImage, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
