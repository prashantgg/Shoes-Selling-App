import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trendtrove/models/shoe.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [];

  List<Shoe> userCart = [];

  Cart() {
    // Initialize the cart with sample data (if needed)
    initializeShoeShop();
  }

  Future<void> initializeShoeShop() async {
    try {
      QuerySnapshot shoeSnapshot =
      await FirebaseFirestore.instance.collection('shoe-details').get();

      shoeShop = shoeSnapshot.docs.map((doc) {
        return Shoe(
          name: doc['name'] ?? '',
          price: doc['price'] ?? '',
          details: doc['details'] ?? '',
          imagePath: doc['img'] ?? '',
        );
      }).toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  List<Shoe> getUserCart() {
    return userCart;
  }

  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }

  int getTotalItems() {
    return userCart.length;
  }

  double getTotalAmount() {
    return userCart.fold<double>(
      0.0,
          (previousValue, shoe) => previousValue + double.parse(shoe.price),
    );
  }

  void buyItems() {
    double totalAmount = getTotalAmount();

    // Print the total amount (you can replace this with your desired action)
    print('Total Amount: \Rs$totalAmount'); // Assuming the price is in dollars

    // Clear the user's cart after the purchase
    userCart.clear();

    notifyListeners();
  }
}
