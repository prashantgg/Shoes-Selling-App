import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trendtrove/home_screen.dart';
import 'package:trendtrove/models/cart.dart';
import 'package:trendtrove/pages/mappage.dart';


class PurchaseDetailsScreen extends StatefulWidget {
  const PurchaseDetailsScreen({Key? key}) : super(key: key);

  @override
  _PurchaseDetailsScreenState createState() => _PurchaseDetailsScreenState();
}

class _PurchaseDetailsScreenState extends State<PurchaseDetailsScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Details'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Shoes Purchased:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.getUserCart().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cart.getUserCart()[index].name),
                      subtitle: Text('\Rs${cart.getUserCart()[index].price}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Total Amount: \Rs${cart.getTotalAmount().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  LatLng? location = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapSample(),
                    ),
                  );
                  setState(() {
                    selectedLocation = location;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    selectedLocation != null
                        ? 'Selected Location: $selectedLocation'
                        : 'Click Here To Select Location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () async {
                      List<Map<String, dynamic>> shoeDetailsList = [];
                      for (var shoe in cart.getUserCart()) {
                        shoeDetailsList.add({
                          'name': shoe.name,
                          'price': shoe.price,
                        });
                      }
                      await FirebaseFirestore.instance
                          .collection('purchases')
                          .add({
                        'shoes': shoeDetailsList,
                        'totalAmount': cart.getTotalAmount(),
                        //'location': selectedLocation?.toJson(), // assuming LatLng has a toJson() method
                      });

                      // Navigate to a thank you screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThankYouScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'CheckOut',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,  // Adjust the size of the check circle icon
              color: Colors.green,  // Change the color of the check circle icon
            ),
            SizedBox(height: 20),
            Text(
              'Thank you for shopping!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Shoes will be delivered in 2 days.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to the home screen and remove all previous routes from the stack
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                      (route) => false,
                );
              },
              child: Text('Go To Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
