import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trcsl_imei_verify_app/components/dialogs.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:trcsl_imei_verify_app/screens/notifications/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/screens/apprval-summary/approval_summary_screen.dart';
import 'package:trcsl_imei_verify_app/screens/device/device-registration.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/contact_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController nicController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imeiController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();
  Map<String, dynamic>? userObj;
  late SharedPreferences _storage;
  final ImagePicker picker = ImagePicker();
  // PickedFile? _file;
  XFile? _imageFile;
  String username = "";
  String email = "";
  String photoURL = "";
  String uid = "";

  @override
  void initState() {
    super.initState();
    getPrefData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPrefData() async {
    _storage = await SharedPreferences.getInstance();

    String? _photoURL = _storage.getString("photoUrl");
    String? _uuid = _storage.getString("UUID");
    String? _username = _storage.getString("username");
    String? _email = _storage.getString("email");

    setState(() {
      username = _username ?? "";
      photoURL = _photoURL ?? "";
      email = _email ?? "";
      uid = _uuid ?? "";
      emailController.text = email;
    });

    print("username is $username");
    print("email is $email");
    print("photoUrl is $photoURL]");
    print("uuid is $uid");
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
            "User Profile",
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: Responsive.isMobileSmall(context)
                  ? size.height * 0.55
                  : Responsive.isMobileMedium(context) ||
                          Responsive.isMobileLarge(context)
                      ? size.height * 0.65
                      : Responsive.isTabletPortrait(context)
                          ? size.width * 0.5
                          : size.width * 0.2,
              width: Responsive.isMobileSmall(context)
                  ? size.width * 0.8
                  : Responsive.isMobileMedium(context) ||
                          Responsive.isMobileLarge(context)
                      ? size.width * 0.95
                      : Responsive.isTabletPortrait(context)
                          ? size.width * 0.8
                          : size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // border: Border.all(color: Colors.black.withOpacity(0.2)),
                border: Border.all(style: BorderStyle.none),
              ),
              child: Builder(builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "USER PROFILE",
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
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(photoURL == ""
                                      ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                                      : "${photoURL}"),
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                right: -30,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottomSheet()),
                                    );
                                  },
                                  elevation: 1.0,
                                  fillColor: Color(0xFFF5F6F9),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  padding: EdgeInsets.all(5.0),
                                  shape: CircleBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text(
                      //   username == "" ? "User Name" : "${username}",
                      //   style: TextStyle(fontSize: 20, color: Colors.black),
                      // ),
                      SizedBox(height: 20),
                      nameField(size),
                      emailField(size),
                      nicField(size),
                      addressField(size),
                      addressField(size),
                      addressField(size),
                      ElevatedButton(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: Responsive.isMobileSmall(context)
                                ? 15
                                : Responsive.isMobileMedium(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 17
                                    : Responsive.isTabletPortrait(context)
                                        ? 20
                                        : 20,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[900]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Responsive.isMobileSmall(context)
                                ? Size(90, 17)
                                : Responsive.isMobileMedium(context)
                                    ? Size(120, 40)
                                    : Responsive.isMobileLarge(context)
                                        ? Size(120, 40)
                                        : Responsive.isTabletPortrait(context)
                                            ? Size(120, 30)
                                            : Size(130, 35),
                          ),
                        ),
                        onPressed: () {
                          successfullPopup(
                            context,
                            "assets/images/check-mark.png",
                            "SUCCESS",
                            "Your profile has been updated successfully.",
                            okHandler,
                            Colors.green[700]!,
                          );
                        },
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }

  void takePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  void okHandler() {
    closeDialog(context);
  }

  Widget bottomSheet() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      child: Column(children: [
        Text(
          'Choose Profile Photo',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Column(
          children: [
            ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue[900]),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                label: Text(
                  "From Gallery",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue[900]),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                label: Text(
                  "From Camera",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ]),
    );
  }

  Widget emailField(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: emailController,
        readOnly: true,
        autocorrect: true,
        style: TextStyle(
          fontSize: Responsive.isMobileMedium(context)
              ? size.width * 0.035
              : Responsive.isTabletPortrait(context)
                  ? size.width * 0.016
                  : size.width * 0.06,
          height: 1.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.grey[400],
            size: Responsive.isMobileSmall(context)
                ? size.width * 0.06
                : Responsive.isMobileMedium(context)
                    ? size.width * 0.06
                    : Responsive.isMobileLarge(context)
                        ? size.width * 0.06
                        : Responsive.isTabletPortrait(context)
                            ? size.width * 0.035
                            : size.width * 0.025,
          ),
          fillColor: Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget nameField(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: emailController,
        readOnly: true,
        autocorrect: true,
        style: TextStyle(
          fontSize: Responsive.isMobileMedium(context)
              ? size.width * 0.035
              : Responsive.isTabletPortrait(context)
                  ? size.width * 0.016
                  : size.width * 0.06,
          height: 1.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.verified_user,
            color: Colors.grey[400],
            size: Responsive.isMobileSmall(context)
                ? size.width * 0.06
                : Responsive.isMobileMedium(context)
                    ? size.width * 0.06
                    : Responsive.isMobileLarge(context)
                        ? size.width * 0.06
                        : Responsive.isTabletPortrait(context)
                            ? size.width * 0.035
                            : size.width * 0.025,
          ),
          fillColor: Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget addressField(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        maxLines: 1,
        controller: emailController,
        readOnly: false,
        autocorrect: true,
        style: TextStyle(
          fontSize: Responsive.isMobileMedium(context)
              ? size.width * 0.035
              : Responsive.isTabletPortrait(context)
                  ? size.width * 0.016
                  : size.width * 0.06,
          height: 1.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.home,
            color: Colors.grey[400],
            size: Responsive.isMobileSmall(context)
                ? size.width * 0.06
                : Responsive.isMobileMedium(context)
                    ? size.width * 0.06
                    : Responsive.isMobileLarge(context)
                        ? size.width * 0.06
                        : Responsive.isTabletPortrait(context)
                            ? size.width * 0.035
                            : size.width * 0.025,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget nicField(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: emailController,
        readOnly: true,
        autocorrect: true,
        style: TextStyle(
          fontSize: Responsive.isMobileMedium(context)
              ? size.width * 0.035
              : Responsive.isTabletPortrait(context)
                  ? size.width * 0.016
                  : size.width * 0.06,
          height: 1.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.card_membership,
            color: Colors.grey[400],
            size: Responsive.isMobileSmall(context)
                ? size.width * 0.06
                : Responsive.isMobileMedium(context)
                    ? size.width * 0.06
                    : Responsive.isMobileLarge(context)
                        ? size.width * 0.06
                        : Responsive.isTabletPortrait(context)
                            ? size.width * 0.035
                            : size.width * 0.025,
          ),
          fillColor: Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
