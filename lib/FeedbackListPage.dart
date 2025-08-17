import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FeedbackListPage extends StatefulWidget {
  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback List',style: TextStyle(
      color: Colors.white, 
      shadows: [
        Shadow(
          offset: Offset(1.0, 1.0), 
          blurRadius: 3.0,
          color: Color.fromARGB(150, 0, 0, 0), 
        ),
      ],
    ),
  ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Facility Feedback'),
            _buildFeedbackList(
              _database.child('Feedback/Facility_Feedback').onValue,
            ),
            _buildSectionTitle('Machine Feedback'),
            _buildFeedbackList(
              _database.child('Feedback/Machine_Feedback').onValue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildFeedbackList(Stream<DatabaseEvent> stream) {
    return StreamBuilder<DatabaseEvent>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          Map<dynamic, dynamic> feedbackMap =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<Widget> feedbackWidgets = [];
          feedbackMap.forEach((key, value) {
            String user = value['user'];
            String feedback = value['feedback'];
            String? adminResponse = value['response'];
            feedbackWidgets.add(
              _buildFeedbackItem(feedback, user, adminResponse: adminResponse),
            );
          });
          return Column(children: feedbackWidgets);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildFeedbackItem(
    String feedback,
    String user, {
    String? machineId,
    String? adminResponse,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feedback,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          if (machineId != null)
            Text(
              'Machine: $machineId',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          SizedBox(height: 4.0),
          Text(
            'By: $user',
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Admin Response:',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            adminResponse ?? 'No admin response yet',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}