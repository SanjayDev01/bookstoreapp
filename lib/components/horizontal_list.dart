import 'package:bookstoreapp/components/showcase.dart';
import 'package:bookstoreapp/models/books.dart';
import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  const HorizontalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xfff0f0f0), width: 2)),
        ),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: booklist.books.length,
                itemBuilder: (BuildContext context, int i) {
                  if (booklist.books[i].franchise) {
                    return ShowCase(
                      wideImage: booklist.books[i].cover,
                      bookObject: booklist.books[i],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
