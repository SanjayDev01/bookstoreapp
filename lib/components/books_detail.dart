// ignore_for_file: no_logic_in_create_state, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class BooksDetails extends StatefulWidget {
  final String title;
  final String author;
  final String cover;
  final double price;
  const BooksDetails({
    Key? key,
    required this.title,
    required this.author,
    required this.cover,
    required this.price,
  }) : super(key: key);

  @override
  State<BooksDetails> createState() => _BooksDetailsState(
        author: author,
        title: title,
        cover: cover,
        price: price,
      );
}

class _BooksDetailsState extends State<BooksDetails> {
  final String title;
  final String author;
  final String cover;
  final double price;
  bool isFavorite = false;
  bool addToCart = false;

  _BooksDetailsState({
    required this.title,
    required this.author,
    required this.cover,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
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
                        onPressed: () {},
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
