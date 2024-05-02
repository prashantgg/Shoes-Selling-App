import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/shoe.dart';

class ShoeTiles extends StatefulWidget {
  const ShoeTiles({Key? key}) : super(key: key);

  @override
  CarTilesState createState() => CarTilesState();
}

Widget shoeTiles(BuildContext context) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('shoe-details').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        var data = snapshot.data!.docs;
        return ListView.builder(
          scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return shoeTileItem(context, data[index]);
          },
        );
      }
    },
  );
}

Widget shoeTileItem(
    BuildContext context, QueryDocumentSnapshot<Object?> shoeData) {
  String imageUrl = shoeData.get('img');
  String shoename = shoeData.get('name');
  String shoedetails = shoeData.get('details');
  String price = shoeData.get('price');

  return GestureDetector(
    onTap: () {
      // Create a Shoe instance from the data
      Shoe selectedShoe = Shoe(
        name: shoename,
        details: shoedetails,
        price: price,
        imagePath: imageUrl,
      );

      // Add the selected shoe to the cart
      Provider.of<Cart>(context, listen: false).addItemToCart(selectedShoe);

      // Show a confirmation message (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          content: Text('$shoename added to cart'),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 25),
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            shoedetails,
            style: TextStyle(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    shoename,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\Rs $price',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),


                child: const Icon(


                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}




class CarTilesState extends State<ShoeTiles> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 650,
        // Adjust the height as needed
        child: shoeTiles(context),
      ),
    );
  }
}
