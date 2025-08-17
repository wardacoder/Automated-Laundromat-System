import 'package:automated_laudromat/RegistrationPage.dart';
import 'package:automated_laudromat/RegularPage';
import 'package:automated_laudromat/VisitorPage';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginAsRegularMember() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to the regular member dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegularMemberPage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password, please try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format, please enter a valid email.';
      } else {
        errorMessage = 'An error occurred, please try again later.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      // Handle other errors
      print('Login error: $e');
      // Display a generic error message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred, please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _loginAsVisitor() {
    // Generate a unique visitor ID and store the visitor's information in the database
    String visitorId = 'visitor_${DateTime.now().millisecondsSinceEpoch}';
    // Navigate to the visitor dashboard
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => VisitorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    'Login to Automated Laundromat',
    style: TextStyle(
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _loginAsRegularMember,
              child: Text('  Login as Regular Member  ',
              style: TextStyle(fontSize: 13.0, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _loginAsVisitor,
              child: Text('  Login as Visitor  ',
              style: TextStyle(fontSize: 13.0, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('Register as Regular Member'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}