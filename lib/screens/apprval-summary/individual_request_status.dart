import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/screens/apprval-summary/approval_summary_screen.dart';
import 'package:trcsl_imei_verify_app/screens/device/device-registration.dart';
import 'package:trcsl_imei_verify_app/screens/notifications/notifications.dart';
import 'package:trcsl_imei_verify_app/screens/profile/user_profile.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/contact_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';

class IndividualRequestStatus extends StatefulWidget {
  const IndividualRequestStatus({super.key});

  @override
  State<IndividualRequestStatus> createState() =>
      _IndividualRequestStatusState();
}

class _IndividualRequestStatusState extends State<IndividualRequestStatus> {
  // SIDE MENU BAR UI
  List<String> _menuOptions = [
    'Device Registration',
    'Approval Summary',
    'About Us',
    'Contact Us',
    'Help',
    'Log Out'
  ];

  // --------- Side Menu Bar Navigation ---------- //
  void choiceAction(String choice) async {
    if (choice == _menuOptions[0]) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DeviceRegistrationScreen(),
        ),
      );
    } else if (choice == _menuOptions[1]) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RequestStatusScreen(),
        ),
      );
    } else if (choice == _menuOptions[2]) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AboutUsScreen(),
        ),
      );
    } else if (choice == _menuOptions[3]) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ContactUsScreen(),
        ),
      );
    } else if (choice == _menuOptions[4]) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HelpScreen(),
        ),
      );
    } else if (choice == _menuOptions[5]) {
      GoogleSignIn().signOut();

      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        leading: Theme(
          data: Theme.of(context).copyWith(
            cardColor: Colors.white,
          ),
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.menu,
              size: 30,
              color: Color.fromARGB(255, 6, 55, 128),
            ),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return _menuOptions.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      fontSize: size.width * 0.044,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ),
        automaticallyImplyLeading: true,
        elevation: 8,
        centerTitle: true,
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Home",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.3),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NotificationsScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Color.fromARGB(255, 6, 55, 128),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 3.0,
                    child:
                        Icon(Icons.brightness_1, size: 11.0, color: Colors.red),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UserProfileScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.person,
                size: 30,
                color: Color.fromARGB(255, 6, 55, 128),
              ),
            ),
          ),
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              'assets/images/trcsl.png',
              width: 200,
              height: 100,
            ),
          ),
        ],
      ))),
    );
  }
}
