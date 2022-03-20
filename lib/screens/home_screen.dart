// ignore_for_file: prefer_final_fields

import 'package:bookstoreapp/components/advanced_search.dart';
import 'package:bookstoreapp/components/book_stores.dart';
import 'package:bookstoreapp/components/books_detail.dart';
import 'package:bookstoreapp/components/categories.dart';
import 'package:bookstoreapp/components/homepage.dart';
import 'package:bookstoreapp/components/wishlist.dart';
import 'package:bookstoreapp/models/books.dart';
import 'package:bookstoreapp/screens/cart_screen.dart';
import 'package:bookstoreapp/screens/splash_screen.dart';
import 'package:bookstoreapp/screens/voice_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.blue.shade800;
  Color unselectedColor = Colors.black;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const BookStores(),
    const AdvancedSearch(),
    const CategoriesScreen(),
    const WishList(),
  ];

  _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share("check bookstore app https://bookstore.com",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Store'),
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const VoiceSearch();
              }));
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _onShare(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Book Store',
                  style: TextStyle(
                    fontSize: 30,
                  )),
            ),
            ListTile(
              title: const Text('Home'),
              leading: Icon(Icons.home_outlined),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SafeArea(child: HomePage());
                }));
              },
            ),
            ListTile(
              title: const Text('Bookstores'),
              leading: Icon(Icons.bookmarks_outlined),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SafeArea(child: BookStores());
                }));
              },
            ),
            ListTile(
              title: const Text('Full list of categories'),
              leading: Icon(Icons.search),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SafeArea(child: CategoriesScreen());
                }));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Advanced Search'),
              leading: Icon(Icons.menu),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SafeArea(child: AdvancedSearch());
                }));
              },
            ),
            ListTile(
              title: const Text('My WishList'),
              leading: Icon(Icons.favorite_border_outlined),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SafeArea(child: WishList());
                }));
              },
            ),
            ListTile(
              title: const Text('My Cart'),
              leading: Icon(Icons.shopping_cart_outlined),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SafeArea(child: CartList());
                }));
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              leading: Icon(Icons.logout),
              onTap: () {
                signout();
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedItemPosition),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 65,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        // shape: bottomBarShape,
        // padding: padding,
        backgroundColor: Colors.black12,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 35,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmarks_outlined,
                size: 35,
              ),
              label: 'bookstores'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 35,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                size: 35,
              ),
              label: 'category'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                size: 35,
              ),
              label: 'favorites'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
