import 'package:bookstoreapp/components/books_detail.dart';
import 'package:bookstoreapp/models/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdvancedSearch extends StatefulWidget {
  const AdvancedSearch({Key? key}) : super(key: key);

  @override
  State<AdvancedSearch> createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  final _formKey = GlobalKey<FormState>();
  List<Book> newBookList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                //search boc
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Search Books",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          newBookList = [];
                          for (var i = 0; i < booklist.books.length; i++) {
                            if (booklist.books[i].title
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              newBookList.add(booklist.books[i]);
                            }
                          }
                        });
                      },
                      onSaved: (value) {
                        print(value);

                        setState(() {
                          newBookList = [];
                          for (var i = 0; i < booklist.books.length; i++) {
                            if (booklist.books[i].title
                                .toLowerCase()
                                .contains(value!.toLowerCase())) {
                              newBookList.add(booklist.books[i]);
                            }
                          }
                        });
                      },
                      onFieldSubmitted: (value) {
                        print(value);

                        setState(() {
                          newBookList = [];
                          for (var i = 0; i < booklist.books.length; i++) {
                            if (booklist.books[i].title
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              newBookList.add(booklist.books[i]);
                            }
                          }
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: newBookList.length,
                    itemBuilder: (BuildContext context, int i) {
                      // ignore: unnecessary_null_comparison
                      if (booklist.books.isNotEmpty) {
                        return BooksDetails(
                          title: newBookList[i].title,
                          author: newBookList[i].author,
                          cover: newBookList[i].cover,
                          price: newBookList[i].price,
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
            )),
      ),
    );
  }
}
