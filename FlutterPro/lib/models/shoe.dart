import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String name;
  final String price;
  final String details;
  final String imagePath; // Update this to store the image URL

  Shoe({
    required this.name,
    required this.price,
    required this.details,
    required this.imagePath,
  });

  // Factory method to create a Shoe object from a Firestore document
  factory Shoe.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return Shoe(
      name: data?['name'] ?? '',
      price: data?['price'] ?? '',
      details: data?['details'] ?? '',
      imagePath: data?['img'] ?? '',
    );
  }
}
