import 'package:bookstoreapp/models/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/signin.dart';
import 'books_detail.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Book> bookslist = [];
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    getUserId();
    getFavBooks();
  }

//get userId
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id")!;
    print(userId);
  }

//fetch books from firebase
  getFavBooks() async {
    EasyLoading.show(status: 'loading...');

    await users.doc(userId).collection("fav books").get().then((value) {
      setState(() {
        bookslist = value.docs.map((doc) => Book.fromDocument(doc)).toList();
      });
    });

    EasyLoading.dismiss();

    print(bookslist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your Wishlist",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade900,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: bookslist.length,
              itemBuilder: (BuildContext context, int i) {
                // ignore: unnecessary_null_comparison
                if (bookslist.isNotEmpty) {
                  return BooksDetails(
                    title: bookslist[i].title,
                    author: bookslist[i].author,
                    cover: bookslist[i].cover,
                    price: bookslist[i].price,
                    isFav: true,
                    isCart: false,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
