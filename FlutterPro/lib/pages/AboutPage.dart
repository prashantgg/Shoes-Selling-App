import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to TrendTrove Shoes Shop, where style meets comfort! 👟',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'At TrendTrove, we\'re passionate about helping you put your best foot forward. Our shoe shop app is more than just a place to buy footwear; it\'s a fashion destination tailored to your unique style. Whether you\'re stepping into the latest trends, searching for everyday essentials, or looking for that perfect pair to make a statement, TrendTrove has you covered.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Mission:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Elevating your shoe-shopping experience is at the core of what we do. We strive to offer a curated collection of high-quality shoes that blend fashion, functionality, and affordability. Our mission is to empower individuals to express themselves through their footwear, making every step a confident stride.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'What Sets Us Apart:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '- Diverse Selection: Discover a wide range of shoes for every occasion, from casual sneakers to elegant heels and everything in between.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Quality Assurance: We source our products from reputable brands and ensure each pair meets our rigorous quality standards.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- User-Friendly App: TrendTrove\'s app is designed with you in mind. Enjoy a seamless and intuitive shopping experience from browse to checkout.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Stay Connected:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Follow us on social media to stay updated on the latest arrivals, exclusive offers, and styling tips. Your feedback and suggestions are invaluable to us as we continue to grow and enhance our services.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Thank you for choosing TrendTrove Shoes Shop. Step into style, step into TrendTrove!',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '👣 Happy Shopping! 👟',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
