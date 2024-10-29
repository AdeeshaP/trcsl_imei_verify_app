import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:trcsl_imei_verify_app/screens/device/device-registration.dart';
import 'package:trcsl_imei_verify_app/screens/apprval-summary/approval_summary_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/contact_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';
import 'package:trcsl_imei_verify_app/screens/notifications/notifications.dart';
import 'package:trcsl_imei_verify_app/screens/profile/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      child: Icon(Icons.brightness_1,
                          size: 11.0, color: Colors.red),
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
        backgroundColor: Colors.lightBlue.shade100,
        body: Container(
          width: size.width,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    'assets/images/trcsl.png',
                    width: Responsive.isMobileSmall(context) ? 150 : 200,
                    height: Responsive.isMobileSmall(context) ? 75 : 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    top: 0,
                    bottom: 10.0,
                  ),
                  child: Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.blue[900],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "TRCSL IMEI Verification",
                      style: GoogleFonts.lato(
                        fontSize: Responsive.isMobileSmall(context)
                            ? 20
                            : Responsive.isMobileMedium(context)
                                ? 22
                                : Responsive.isMobileLarge(context)
                                    ? 23
                                    : Responsive.isTabletPortrait(context)
                                        ? 25
                                        : 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 30.0,
                      crossAxisSpacing: 15.0,
                    ),
                    padding: EdgeInsets.all(8.0),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RequestStatusScreen(),
                            ),
                          );
                        },
                        child: Container(
                          color: Color.fromARGB(255, 4, 46, 108),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "PENDING REQUESTS",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RequestStatusScreen(),
                            ),
                          );
                        },
                        child: Container(
                            color: Colors.green[800],
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "APPROVED IMEIS",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "3",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RequestStatusScreen(),
                            ),
                          );
                        },
                        child: Container(
                            color: Colors.orange[700],
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "REJECTED IMEIS",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "4",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RequestStatusScreen(),
                            ),
                          );
                        },
                        child: Container(
                            color: Color.fromARGB(255, 198, 166, 7),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "VALIDATE IMEIS",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "10",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RequestStatusScreen(),
                            ),
                          );
                        },
                        child: Container(
                            color: Colors.brown,
                            child: Center(
                              child: Text(
                                "APPROVAL SUMMARY",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DeviceRegistrationScreen(),
                            ),
                          );
                        },
                        child: Container(
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                "DEVICE REGISTRATION",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ]),
                SizedBox(
                  height: 60,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        ),
      ),
    );
  }
}
