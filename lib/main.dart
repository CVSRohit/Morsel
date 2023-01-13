import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/signInPage.dart';
import 'Pages/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:firebase_core/firebase_core.dart' as FirebaseCore;
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

// Pending items
// Sizing issues - overfit for the iphone 14 screen size
// Address automation/autocomplete using google maps?

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseCore.Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      customVariables.activeUser.loginStatus = false;
    } else {
      customVariables.activeUser.loginStatus = true;
      customVariables.activeUser.emailID = user.email;
      customVariables.activeUser.userID = user.uid;
      print(customVariables.activeUser.emailID);
      var loggedUser = await FirebaseFirestore.instance
          .collection('user')
          .where('emailID', isEqualTo: customVariables.activeUser.emailID)
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          customVariables.activeUser.userType = doc["Type"] ?? "Buyer";
          customVariables.activeUser.businessAddress =
              doc["businessAddress"] ?? "";
          customVariables.activeUser.businessName = doc["businessName"] ?? "";
        });
      }).onError((error, stackTrace) {
        print(error);
      });
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Morsel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        routes: {
          "/": (context) => splashScreen(),
        });
  }
}
