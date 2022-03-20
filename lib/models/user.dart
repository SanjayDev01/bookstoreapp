import 'package:cloud_firestore/cloud_firestore.dart';

class User1 {
  final String id;
  final String email;
  final String photoUrl;
  final String displayName;

  User1({
    required this.id,
    required this.email,
    required this.photoUrl,
    required this.displayName,
  });

  factory User1.fromDocument(DocumentSnapshot doc) {
    return User1(
      id: doc['id'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
    );
  }
}
