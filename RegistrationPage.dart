// registration_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedClientType = 'Regular Member';

  Future<String> _generateClientId() async {
    DatabaseReference counterRef = _database.child('counters').child('clientId');
    int counter = 0;
    await counterRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        counter = snapshot.value as int;
      }
    });
    counter++;
    await counterRef.set(counter);
    String clientId = 'client_${counter.toString().padLeft(3, '0')}';
    return clientId;
  }

  void _registerRegularMember() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      String userId = userCredential.user!.uid;
      String clientId = await _generateClientId();
      await _database.child('Client').child(clientId).set({
        'Name': _nameController.text,
        'Email': _emailController.text,
        'Phone': _phoneController.text,
        'Client_Type': _selectedClientType,
        'Reward_Points': 0,
        'ClientId': clientId,
      });
      Navigator.pop(context);
    } catch (e) {
      print('Registration error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register',style: TextStyle(
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.0),
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 24.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
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
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedClientType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedClientType = newValue!;
                  });
                },
                items: <String>['Regular Member', 'Admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Are you an authorized admin?',
                  prefixIcon: Icon(Icons.admin_panel_settings),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _registerRegularMember,
                child: Text('Register',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}