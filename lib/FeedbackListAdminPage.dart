import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackListAdminPage extends StatefulWidget {
  @override
  _FeedbackListAdminPageState createState() => _FeedbackListAdminPageState();
}

class _FeedbackListAdminPageState extends State<FeedbackListAdminPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isAdmin => _auth.currentUser?.isAnonymous == false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback', style: TextStyle(
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
          color: Color(0xFF6200EE),
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
            String? machineId = value['machineId'];
            String? adminResponse = value['response'];
            feedbackWidgets.add(
              FeedbackItem(
                feedback: feedback,
                user: user,
                machineId: machineId,
                adminResponse: adminResponse,
                isAdmin: isAdmin,
                feedbackKey: key,
                feedbackType: machineId != null ? 'Machine_Feedback' : 'Facility_Feedback',
              ),
            );
          });
          return Column(children: feedbackWidgets);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FeedbackItem extends StatelessWidget {
  final String feedback;
  final String user;
  final String? machineId;
  final String? adminResponse;
  final bool isAdmin;
  final String feedbackKey;
  final String feedbackType;

  FeedbackItem({
    required this.feedback,
    required this.user,
    this.machineId,
    this.adminResponse,
    required this.isAdmin,
    required this.feedbackKey,
    required this.feedbackType,
  });

  @override
  Widget build(BuildContext context) {
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
                color: const Color.fromARGB(255, 14, 13, 13),
              ),
            ),
          SizedBox(height: 4.0),
          Text(
            'By: $user',
            style: TextStyle(
              fontSize: 14.0,
              color:Theme.of(context).colorScheme.primary,
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
          SizedBox(height: 8.0),
          if (isAdmin)
            _buildRespondButton(context)
          else
            SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildRespondButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          TextEditingController responseController = TextEditingController();
          return AlertDialog(
            title: Text('Respond'),
            content: TextField(
              controller: responseController,
              decoration: InputDecoration(
                hintText: 'Enter your response',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitResponse(
                    feedbackKey,
                    feedbackType,
                    responseController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          );
        },
      );
    },
    child: Text(
      'Respond',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
    ),
  );
}

  void _submitResponse(
    String feedbackKey,
    String feedbackType,
    String response,
  ) {
    final DatabaseReference feedbackRef =
        FirebaseDatabase.instance.reference().child('Feedback/$feedbackType');
    feedbackRef.child(feedbackKey).update({'response': response});
  }
}