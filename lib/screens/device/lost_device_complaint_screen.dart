import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trcsl_imei_verify_app/components/dialogs.dart';
import '../../responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/screens/apprval-summary/approval_summary_screen.dart';
import 'package:trcsl_imei_verify_app/screens/device/device-registration.dart';
import 'package:trcsl_imei_verify_app/screens/notifications/notifications.dart';
import 'package:trcsl_imei_verify_app/screens/profile/user_profile.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/contact_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';

class LostDeviceComplintScreen extends StatefulWidget {
  const LostDeviceComplintScreen({super.key});

  @override
  State<LostDeviceComplintScreen> createState() =>
      _LostDeviceComplintScreenState();
}

class _LostDeviceComplintScreenState extends State<LostDeviceComplintScreen> {
  TextEditingController nicController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController imeiController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();
  bool _validate = false;
  Map<String, dynamic>? userObj;
  File? imageFile;
  FilePickerResult? result;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    modelController.dispose();
    nicController.dispose();
    imeiController.dispose();
    notesController.dispose();
    attachmentController.dispose();
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
            "Lost Devices",
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
        padding: EdgeInsets.symmetric(horizontal: 10),
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
            Form(
              child: Column(children: [
                SizedBox(height: 10),
                // Row(
                //   children: [
                //     Expanded(
                //         flex: 2,
                //         child: CircleAvatar(
                //           backgroundColor: Colors.blue[300],
                //           child: Icon(
                //             Icons.arrow_back_sharp,
                //             size: 30,
                //             color: Colors.white,
                //           ),
                //         )),
                //     Expanded(
                //       flex: 9,
                //       child: Text(
                //         "Lost Device Complaints",
                //         style: GoogleFonts.lato(
                //           textStyle: Theme.of(context).textTheme.headlineSmall,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Text(
                  "Lost Device Complaints",
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly
                    // ],
                    autocorrect: true,
                    controller: nicController,
                    style: TextStyle(
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.06,
                        height: 1.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "NIC ",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.01,
                      ),
                      errorText: _validate && nicController.text.isEmpty
                          ? "NIC number cannot be empty.."
                          : null,
                      hintText: "Enter the NIC number.",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly
                    // ],
                    autocorrect: true,
                    controller: modelController,
                    style: TextStyle(
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.06,
                        height: 1.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Device Model ",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.01,
                      ),
                      errorText: _validate && modelController.text.isEmpty
                          ? "Device Model cannot be empty.."
                          : null,
                      hintText: "Enter the Device Model.",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    autocorrect: true,
                    controller: imeiController,
                    style: TextStyle(
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.06,
                        height: 1.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "IMEI Number ",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.01,
                      ),
                      errorText: _validate && imeiController.text.isEmpty
                          ? "IMEI number cannot be empty.."
                          : null,
                      hintText: "Enter the IMEI number.",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    maxLines: 4,
                    controller: notesController,
                    style: TextStyle(
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.06,
                        height: 1.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Notes ",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.01,
                      ),
                      errorText: _validate && notesController.text.isEmpty
                          ? "Notes cannot be empty.."
                          : null,
                      hintText: "Enter the notes.",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: TextFormField(
                    controller: attachmentController,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Complaint Attachment",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.035
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.016
                                : size.width * 0.01,
                      ),
                      hintText:
                          "If you need, you can attach any evidence documents.",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () async {
                          result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
                          );
                          if (result != null) {
                            PlatformFile file = result!.files.first;
                            setState(() {
                              attachmentController.text = file.name;
                              imageFile = File(file.path!);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 20, 2, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      successfullPopup(
                        context,
                        'assets/images/success-green-icon.png',
                        "Complaint Was Sent Successfully..!!!",
                        "Complaint Was Sent Successfully..!!!",
                        okRecognition,
                        Colors.blue[100]!,
                      );
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.isMobileMedium(context)
                            ? size.width * 0.06
                            : Responsive.isTabletPortrait(context)
                                ? size.width * 0.025
                                : size.width * 0.09,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[900]),
                      minimumSize: Responsive.isMobileSmall(context)
                          ? MaterialStateProperty.all(
                              Size(size.width * 0.5, size.width * 0.12))
                          : Responsive.isMobileMedium(context)
                              ? MaterialStateProperty.all(
                                  Size(size.width * 0.5, size.width * 0.13))
                              : Responsive.isTabletPortrait(context)
                                  ? MaterialStateProperty.all(
                                      Size(size.width * 0.9, size.width * 0.07))
                                  : MaterialStateProperty.all(Size(
                                      size.width * 0.8, size.width * 0.15)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  void okRecognition() {
    closeDialog(context);
  }
}
