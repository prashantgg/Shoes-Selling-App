  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';

  Future<void> saveFeedbacks({
    required BuildContext context,
    required String description,
  }) async {
    try {
      CollectionReference feedbacksCollection =
      FirebaseFirestore.instance.collection('feedbacks');
      User? user = FirebaseAuth.instance.currentUser;

      await feedbacksCollection.add({
        'description': description,
        'userId': user?.uid, // Use user?.uid to get the user ID
      });

      print('Data added to Firestore successfully');
    } catch (error) {
      print('Error adding data to Firestore: $error');
      // You can throw the error here if you want to handle it further.
      throw error;
    }
  }

  class FeedbackPage extends StatefulWidget {
    @override
    _FeedbackPageState createState() => _FeedbackPageState();
  }

  class _FeedbackPageState extends State<FeedbackPage> {
    TextEditingController _feedbackController = TextEditingController();


    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'We value your feedback!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Do you have a suggestion or found some bug?',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Let us know in the fields below.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _feedbackController,
                  maxLines: 10, // Increased maxLines for a taller text box
                  decoration: InputDecoration(
                    hintText: 'Describe your experience here...', // Default text
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement the logic to send feedback to your desired destination
                    _sendFeedback();
                  },
                  child: Text('Send Feedback'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void _sendFeedback() async {
      String feedback = _feedbackController.text;

      if (feedback.isNotEmpty) {
        try {
          // Call the function to save feedback to Firestore
          await saveFeedbacks(context: context, description: feedback);

          // Show a success dialog after feedback is successfully submitted
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Feedback Submitted'),
              content: Text('Thank you for your feedback!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } catch (error) {
          // Show an error dialog if there's an issue with Firestore
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit feedback. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Show an error dialog if feedback is empty
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Please enter your feedback before submitting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(
      MaterialApp(
        home: FeedbackPage(),
      ),
    );
  }
