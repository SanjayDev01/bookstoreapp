import 'package:bookstoreapp/components/books_detail.dart';
import 'package:bookstoreapp/screens/success_screen.dart';
import 'package:flutter/material.dart';

import 'package:bookstoreapp/models/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/signin.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<Book> bookslist = [];
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    getUserId();
    getCartBooks();
  }

//get userId
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id")!;
    print(userId);
  }

//fetch books from firebase
  getCartBooks() async {
    EasyLoading.show(status: 'loading...');

    await users.doc(userId).collection("cart").get().then((value) {
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
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Cart",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  bookslist.length < 1
                      ? "Your Cart is Empty"
                      : "Total Bill ${bookslist.map((e) => e.price).reduce((value, element) => value + element)} \$",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue.shade700,
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
                        isFav: false,
                        isCart: true,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SuccessScreen();
                }));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    return states.contains(MaterialState.selected)
                        ? Colors.yellow.shade600
                        : Colors.yellow.shade700;
                  },
                ),
              ),
              child: Container(
                width: 200,
                child: const Text(
                  "Proceed to Checkout",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
