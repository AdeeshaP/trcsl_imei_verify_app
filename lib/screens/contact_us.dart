import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:trcsl_imei_verify_app/screens/notifications/notifications.dart';
import 'package:trcsl_imei_verify_app/screens/profile/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/screens/apprval-summary/approval_summary_screen.dart';
import 'package:trcsl_imei_verify_app/screens/device/device-registration.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Future<void> _makeLandLineCall1() async {
    String phoneNumber = "+94 11 576 7434";
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
  }

  Future<void> _makeLandLineCall2() async {
    String phoneNumber = "+94 11 269 8635";
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ccontact@auradot.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Add Subject',
        'body': 'Write something...!',
      }),
    );

    launchUrl(emailLaunchUri);
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
            "Contact Us",
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
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/images/trcsl.png',
                width: 200,
                height: 100,
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
            SizedBox(height: 20),
            Text(
              "Version " + "0.0.1",
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: Responsive.isMobileSmall(context)
                    ? 18
                    : Responsive.isMobileMedium(context)
                        ? 19
                        : Responsive.isMobileLarge(context)
                            ? 20
                            : 28,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Text(
                "If you have any questions, please contact us on via email, and we'll respond as soon as possible. "
                "Your feedback matters to us and will allow us to improve our service to you. We would be grateful"
                " if you could take a few minutes to send youd your comments.",
                style: TextStyle(
                  fontSize: Responsive.isMobileSmall(context)
                      ? 14
                      : Responsive.isMobileMedium(context)
                          ? 15.5
                          : Responsive.isMobileLarge(context)
                              ? 16
                              : Responsive.isTabletPortrait(context)
                                  ? 25
                                  : 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.amber[600],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: InkWell(
                    onTap: () {
                      // _sendEmail();
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Head Office\n",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: Responsive.isMobileSmall(context)
                                ? 13
                                : Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 15
                                    : Responsive.isTabletPortrait(context)
                                        ? 24
                                        : 27,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Auradot (pvt) Ltd,\n410/118, Bauddhaloka Mawatha, Colombo 00700",
                          style: TextStyle(
                            height: 1.7,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: Responsive.isMobileSmall(context)
                                ? 13
                                : Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 15
                                    : Responsive.isTabletPortrait(context)
                                        ? 24
                                        : 27,
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Icon(
                    Icons.email,
                    size: 30,
                    color: Colors.blue[800],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: InkWell(
                    onTap: () {
                      _sendEmail();
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Email Address\n",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: Responsive.isMobileSmall(context)
                                ? 13
                                : Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 15
                                    : Responsive.isTabletPortrait(context)
                                        ? 24
                                        : 27,
                          ),
                        ),
                        TextSpan(
                          text: "contact@auradot.com",
                          style: TextStyle(
                            height: 1.8,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: Responsive.isMobileSmall(context)
                                ? 13
                                : Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 15
                                    : Responsive.isTabletPortrait(context)
                                        ? 24
                                        : 27,
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Icon(
                    Icons.phone,
                    size: 30,
                    color: Colors.blue[600],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: InkWell(
                    onTap: () {
                      _makeLandLineCall2();
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Telephone\n",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: Responsive.isMobileSmall(context)
                                ? 13
                                : Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 15
                                    : Responsive.isTabletPortrait(context)
                                        ? 24
                                        : 27,
                          ),
                        ),
                        TextSpan(
                          text: "+94 11 269 8635",
                          style: TextStyle(
                            height: 1.7,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: Responsive.isMobileSmall(context)
                                ? 13
                                : Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 15
                                    : Responsive.isTabletPortrait(context)
                                        ? 24
                                        : 27,
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
