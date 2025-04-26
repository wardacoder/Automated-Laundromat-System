import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  String? _publicName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showFeedbackOptions();
    });
  }

  void _showFeedbackOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Feedback Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _getPublicName(true);
                },
                child: const Text('Facility Feedback'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _getPublicName(false);
                },
                child: const Text('Machine Feedback'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _getPublicName(bool isFacilityFeedback) {
    TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Public Name'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Name visible to the public',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _publicName = _nameController.text;
                });
                Navigator.of(context).pop();
                if (isFacilityFeedback) {
                  _getFacilityFeedback();
                } else {
                  _getMachineFeedback();
                }
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _getFacilityFeedback() {
    TextEditingController _feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Facility Feedback'),
          content: TextField(
            controller: _feedbackController,
            decoration: const InputDecoration(
              hintText: 'Enter your feedback',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String feedback = _feedbackController.text;
                _submitFacilityFeedback(feedback);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _submitFacilityFeedback(String feedback) async {
    var feedbackCountSnapshot = await _database.child('Facility_Feedback_Count').get();
    int feedbackCount = feedbackCountSnapshot.exists ? int.parse(feedbackCountSnapshot.value.toString()) : 0;
    feedbackCount++;
    await _database.child('Facility_Feedback_Count').set(feedbackCount);

    String feedbackId = 'feedback${feedbackCount.toString().padLeft(2, '0')}';
    await _database.child('Feedback/Facility_Feedback/$feedbackId').set({
      'user': _publicName,
      'feedback': feedback,
    });

    _showMessage('Thank you for your feedback!');
    Navigator.of(context).pop();
  }

  void _getMachineFeedback() {
    TextEditingController _bookingIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Booking ID'),
          content: TextField(
            controller: _bookingIdController,
            decoration: const InputDecoration(
              hintText: 'Booking ID',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String bookingId = _bookingIdController.text;
                _retrieveMachineId(bookingId);
                Navigator.of(context).pop();
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _retrieveMachineId(String bookingId) {
    _database.child('Bookings/$bookingId/machineId').once().then((snapshot) {
      String machineId = snapshot.snapshot.value as String;
      _getMachineFeedbackInput(machineId);
    });
  }

  void _getMachineFeedbackInput(String machineId) {
    TextEditingController _feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Feedback for $machineId'),
          content: TextField(
            controller: _feedbackController,
            decoration: const InputDecoration(
              hintText: 'Enter your feedback',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String feedback = _feedbackController.text;
                _submitMachineFeedback(machineId, feedback);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _submitMachineFeedback(String machineId, String feedback) async {
    var feedbackCountSnapshot = await _database.child('Machine_Feedback_Count').get();
    int feedbackCount = feedbackCountSnapshot.exists ? int.parse(feedbackCountSnapshot.value.toString()) : 0;
    feedbackCount++;
    await _database.child('Machine_Feedback_Count').set(feedbackCount);

    String feedbackId = 'feedback${feedbackCount.toString().padLeft(2, '0')}';
    await _database.child('Feedback/Machine_Feedback/$feedbackId').set({
      'user': _publicName,
      'machineId': machineId,
      'feedback': feedback,
    });

    _showMessage('Thank you for your feedback!');
    Navigator.of(context).pop();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Feedback'),
      ),
      body: Center(
        child: Text('Submitting feedback...'),
      ),
    );
  }
}