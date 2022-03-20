import 'package:bookstoreapp/components/books_detail.dart';
import 'package:bookstoreapp/components/showcase.dart';
import 'package:bookstoreapp/models/books.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Top Franchise Books",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                top: 20.0,
              ),
              child: Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: booklist.books.length,
                  itemBuilder: (BuildContext context, int i) {
                    // ignore: unnecessary_null_comparison
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
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Popular Books",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: booklist.books.length,
                itemBuilder: (BuildContext context, int i) {
                  // ignore: unnecessary_null_comparison
                  if (booklist.books.isNotEmpty) {
                    return BooksDetails(
                      title: booklist.books[i].title,
                      author: booklist.books[i].author,
                      cover: booklist.books[i].cover,
                      price: booklist.books[i].price,
                      isFav: false,
                      isCart: false,
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
