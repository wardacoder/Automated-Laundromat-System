// main.dart
import 'package:automated_laudromat/LoginPage.dart';
import 'package:automated_laudromat/RegularPage';
import 'package:automated_laudromat/VisitorPage';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  // Ensures proper initialization of Flutter bindings before executing the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Conditional initialization for Firebase specifically tailored for web platforms.
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDB_DuQh2xZ2Cl3oBOo0hL-kB-drVycsTI",
        authDomain: "automatedlaundromatcoe420.firebaseapp.com",
        databaseURL: "https://automatedlaundromatcoe420-default-rtdb.firebaseio.com",
        projectId: "automatedlaundromatcoe420",
        storageBucket: "automatedlaundromatcoe420.appspot.com",
        messagingSenderId: "111710858133",
        appId: "1:111710858133:web:017dd33edb41dcf87ce49c",
        measurementId: "G-M0KPKYFFCM"
       
      ),
    );
  }

  // General Firebase initialization for all platforms.
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automated Laundromat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 44, 24, 78)),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in, determine the user type and navigate to the respective page
            User user = snapshot.data!;
            // Query the user data from the Firebase Realtime Database to determine the user type
            return FutureBuilder<DataSnapshot>(
              future: FirebaseDatabase.instance.reference().child('Client').child(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.exists) {
                    // User exists in the database, check the user type
                    Map<dynamic, dynamic> data = snapshot.data!.value as Map<dynamic, dynamic>;
                    String userType = data['Client_Type'];
                    if (userType == 'Regular Member') {
                      return RegularMemberPage();
                    } else if (userType == 'Visitor') {
                      return VisitorPage();
                    }
                  }
                }
                // User type not determined or user doesn't exist in the database
                return LoginPage();
              },
            );
          } else {
            // User is not logged in, navigate to the login page
            return LoginPage();
          }
        },
      ),
    );
  }
}