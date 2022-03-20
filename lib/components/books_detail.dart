// ignore_for_file: no_logic_in_create_state, avoid_unnecessary_containers

import 'dart:convert';

import 'package:bookstoreapp/auth/signin.dart';
import 'package:bookstoreapp/screens/cart_screen.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class BooksDetails extends StatefulWidget {
  final String title;
  final String author;
  final String cover;
  final double price;
  final bool isFav;
  final bool isCart;

  const BooksDetails({
    Key? key,
    required this.title,
    required this.author,
    required this.isFav,
    required this.cover,
    required this.price,
    required this.isCart,
  }) : super(key: key);

  @override
  State<BooksDetails> createState() => _BooksDetailsState(
        author: author,
        title: title,
        cover: cover,
        price: price,
        isFav: isFav,
        isCart: isCart,
      );
}

class _BooksDetailsState extends State<BooksDetails> {
  final String title;
  final String author;
  final String cover;
  final double price;
  bool isFavorite = false;
  bool addToCart = false;
  final bool isFav;
  final bool isCart;

  var uuid = const Uuid().v4();

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  _BooksDetailsState({
    required this.title,
    required this.author,
    required this.cover,
    required this.price,
    required this.isFav,
    required this.isCart,
  });

  @override
  void initState() {
    super.initState();
    getUserId();
    checkFav();
    checkCart();
  }

  //get userid from local storage
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id")!;
    print(userId);
  }

//to add book to wishlist
  addFav() async {
    //Call the user's CollectionReference to add a new document
    await users
        .doc(userId)
        .collection("fav books")
        .doc(uuid)
        .set({
          "title": title,
          "author": author,
          "cover": cover,
          "price": price.toString(),
        })
        .then((value) => print("User's Favourite Added"))
        .catchError((error) => print("Failed to add User's Favourite: $error"));
  }

//to delete the whishlist book
  removeFav() async {
    await users
        .doc(userId)
        .collection("fav books")
        .doc(uuid)
        .delete()
        .then((value) => print("User Fav deleted"))
        .catchError(
            (error) => print("Failed to delete User's Favourite: $error"));

    setState(() {});
  }

  // add book to the cart
  addCart() async {
    await users
        .doc(userId)
        .collection("cart")
        .doc(uuid)
        .set({
          "title": title,
          "author": author,
          "cover": cover,
          "price": price.toString(),
        })
        .then((value) => print("book added to the car"))
        .catchError((error) => print("Failed to add book to cart: $error"));
  }

// remove item from the cart
  removeCart() async {
    await users
        .doc(userId)
        .collection("cart")
        .doc(uuid)
        .delete()
        .then((value) => print("User book deleted from cart"))
        .catchError(
            (error) => print("Failed to delete book from cart : $error"));
    setState(() {});
  }

  checkFav() {
    if (isFav) {
      setState(() {
        isFavorite = true;
      });
    } else {
      isFavorite = false;
    }
  }

  checkCart() {
    if (isCart) {
      setState(() {
        addToCart = true;
      });
    } else {
      addToCart = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(cover, fit: BoxFit.cover),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      author,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${price.toString()} \$",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Row(
                        children: [
                          isFavorite
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                    removeFav();
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = true;
                                    });
                                    addFav();
                                  },
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 1,
                            height: 30,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                          addToCart
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      addToCart = !addToCart;
                                    });
                                    removeCart();
                                  },
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      addToCart = true;
                                    });
                                    addCart();
                                  },
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartList()));
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
                          width: 100,
                          child: const Text(
                            "Buy Now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            )),
          ],
        ),
        elevation: 10.0,
        borderOnForeground: false,
      ),
    );
  }
}
