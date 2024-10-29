import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:trcsl_imei_verify_app/screens/device/device-registration.dart';
import 'package:trcsl_imei_verify_app/screens/notifications/notifications.dart';
import 'package:trcsl_imei_verify_app/screens/profile/user_profile.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/contact_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';

class RequestStatusScreen extends StatefulWidget {
  const RequestStatusScreen({super.key});

  @override
  State<RequestStatusScreen> createState() => _RequestStatusScreenState();
}

class _RequestStatusScreenState extends State<RequestStatusScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            "Approval Summary",
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showBottomBorder: true,
                    dividerThickness: 2,
                    headingRowColor:
                        MaterialStateProperty.all(Colors.blue[300]),
                    dataRowColor: MaterialStateProperty.all(Colors.white),
                    columns: [
                      DataColumn(
                          label: Text(
                        'ID',
                        style: TextStyle(
                          fontSize: Responsive.isMobileSmall(context)
                              ? 14
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 15
                                  : Responsive.isTabletPortrait(context)
                                      ? 17
                                      : 19,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'IMEI',
                        style: TextStyle(
                          fontSize: Responsive.isMobileSmall(context)
                              ? 14
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 15
                                  : Responsive.isTabletPortrait(context)
                                      ? 17
                                      : 19,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Device Name',
                        style: TextStyle(
                          fontSize: Responsive.isMobileSmall(context)
                              ? 14
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 15
                                  : Responsive.isTabletPortrait(context)
                                      ? 17
                                      : 19,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Date',
                        style: TextStyle(
                          fontSize: Responsive.isMobileSmall(context)
                              ? 14
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 15
                                  : Responsive.isTabletPortrait(context)
                                      ? 17
                                      : 19,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Status',
                        style: TextStyle(
                          fontSize: Responsive.isMobileSmall(context)
                              ? 14
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 15
                                  : Responsive.isTabletPortrait(context)
                                      ? 17
                                      : 19,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Action',
                        style: TextStyle(
                          fontSize: Responsive.isMobileSmall(context)
                              ? 14
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 15
                                  : Responsive.isTabletPortrait(context)
                                      ? 17
                                      : 19,
                        ),
                      )),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "001",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "008623128128181 ",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Huawei Y7P",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "2024-03-10",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 3
                                    : Responsive.isTabletPortrait(context)
                                        ? 5
                                        : 7,
                                horizontal: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 7
                                    : Responsive.isTabletPortrait(context)
                                        ? 10
                                        : 14,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2)),
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 14
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? 15
                                          : Responsive.isTabletPortrait(context)
                                              ? 17
                                              : 19,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "002",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "008623128128181",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Huawei Y12",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "2024-01-09",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 3
                                    : Responsive.isTabletPortrait(context)
                                        ? 5
                                        : 7,
                                horizontal: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 7
                                    : Responsive.isTabletPortrait(context)
                                        ? 10
                                        : 14,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2)),
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 14
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? 15
                                          : Responsive.isTabletPortrait(context)
                                              ? 17
                                              : 19,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "003",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "008623121213101",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Nokia A12",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "2024-01-10",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Approved",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 3
                                    : Responsive.isTabletPortrait(context)
                                        ? 5
                                        : 7,
                                horizontal: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 7
                                    : Responsive.isTabletPortrait(context)
                                        ? 10
                                        : 14,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2)),
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 14
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? 15
                                          : Responsive.isTabletPortrait(context)
                                              ? 17
                                              : 19,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "004",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "002145535433352",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "OPPO A57",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "2023-01-15",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 3
                                    : Responsive.isTabletPortrait(context)
                                        ? 5
                                        : 7,
                                horizontal: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 7
                                    : Responsive.isTabletPortrait(context)
                                        ? 10
                                        : 14,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2)),
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 14
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? 15
                                          : Responsive.isTabletPortrait(context)
                                              ? 17
                                              : 19,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "005",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "008623165445122",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Samsung Galaxy S22",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "2024-02-04",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Text(
                              "Rejected",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 19,
                              ),
                            ),
                            onTap: () {},
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 3
                                    : Responsive.isTabletPortrait(context)
                                        ? 5
                                        : 7,
                                horizontal: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 7
                                    : Responsive.isTabletPortrait(context)
                                        ? 10
                                        : 14,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2)),
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 14
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? 15
                                          : Responsive.isTabletPortrait(context)
                                              ? 17
                                              : 19,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
