import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/screens/apprval-summary/approval_summary_screen.dart';
import 'package:trcsl_imei_verify_app/screens/device/device-registration.dart';
import 'package:trcsl_imei_verify_app/screens/profile/user_profile.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/contact_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'dart:convert';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> data1 = [];
  SharedPreferences? pref;
  bool visitNotificicationPage = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    pref = await SharedPreferences.getInstance();

    final String response =
        await rootBundle.loadString('assets/json/niweeme_paniwida.json');
    final data = await json.decode(response);

    setState(() {
      data1 = List<Map<String, dynamic>>.from(data['data']);
    });

    pref!.setBool('visitNotificicationPage', visitNotificicationPage);
  }

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
            "Notifications",
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
      backgroundColor: Colors.lightBlue.shade100,
      body: Container(
        color: Colors.lightBlue.shade100,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
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
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "NOTIFICATIONS",
                          style: TextStyle(
                            fontSize: Responsive.isMobileSmall(context)
                                ? 18
                                : Responsive.isMobileMedium(context)
                                    ? 19
                                    : Responsive.isMobileLarge(context)
                                        ? 19
                                        : Responsive.isTabletPortrait(context)
                                            ? 24
                                            : 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data1.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: Responsive.isMobileSmall(
                                                    context)
                                                ? 5
                                                : Responsive.isMobileMedium(
                                                            context) ||
                                                        Responsive
                                                            .isMobileLarge(
                                                                context)
                                                    ? 5
                                                    : Responsive
                                                            .isTabletLandscape(
                                                                context)
                                                        ? 15
                                                        : 15),
                                        child: Row(children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              data1[index]['id'].toString(),
                                              style: TextStyle(
                                                fontSize: Responsive
                                                        .isMobileSmall(context)
                                                    ? 15
                                                    : Responsive.isMobileMedium(
                                                                context) ||
                                                            Responsive
                                                                .isMobileLarge(
                                                                    context)
                                                        ? 16
                                                        : Responsive
                                                                .isTabletLandscape(
                                                                    context)
                                                            ? 20
                                                            : 24,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Text(
                                              data1[index]['name'],
                                              style: GoogleFonts.notoSerif(
                                                fontSize: Responsive
                                                        .isMobileSmall(context)
                                                    ? 12
                                                    : Responsive.isMobileMedium(
                                                                context) ||
                                                            Responsive
                                                                .isMobileLarge(
                                                                    context)
                                                        ? 12.5
                                                        : Responsive
                                                                .isTabletLandscape(
                                                                    context)
                                                            ? 17
                                                            : 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: Responsive.isMobileSmall(
                                                      context)
                                                  ? 16
                                                  : Responsive.isMobileMedium(
                                                              context) ||
                                                          Responsive
                                                              .isMobileLarge(
                                                                  context)
                                                      ? 17
                                                      : Responsive
                                                              .isTabletLandscape(
                                                                  context)
                                                          ? 18
                                                          : 19,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
