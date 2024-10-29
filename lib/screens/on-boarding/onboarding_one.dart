import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trcsl_imei_verify_app/components/dialogs.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trcsl_imei_verify_app/screens/home/home_screen.dart';

class OnboardingProfile extends StatefulWidget {
  const OnboardingProfile({super.key});

  @override
  State<OnboardingProfile> createState() => _OnboardingProfileState();
}

class _OnboardingProfileState extends State<OnboardingProfile> {
  final Color kDarkBlueColor = Color.fromARGB(255, 9, 156, 236);
  final Color slideBtnColor = Colors.black;
  TextEditingController iDPatternController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final actionBtnColor = Colors.blue[900];
  late SharedPreferences _storage;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> forthTabNavKey = GlobalKey<NavigatorState>();
  final ImagePicker picker = ImagePicker();
  XFile? _imageFile;
  String username = "";
  String email = "";
  String photoURL = "";
  String uid = "";
  String nicType = "NIC";

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
      nameController.text = username;
    });
  }

  void takePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      _imageFile = pickedFile;
    });
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
                  backgroundColor: MaterialStatePropertyAll(actionBtnColor),
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
                  backgroundColor: MaterialStatePropertyAll(actionBtnColor),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // return OnBoardingSlider(
    //   finishButtonText: 'Complete Profile',
    //   onFinish: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => HomePage(),
    //       ),
    //     );
    //   },
    //   finishButtonTextStyle: TextStyle(fontSize: 18, color: Colors.white),
    //   finishButtonStyle: FinishButtonStyle(
    //     backgroundColor: Colors.blue[900],
    //   ),
    //   controllerColor: slideBtnColor,
    //   totalPage: 1,
    //   headerBackgroundColor: Colors.green,
    //   pageBackgroundColor: Colors.lightBlue.shade100,
    //   background: [
    //     Text(""),
    //   ],
    //   speed: 1.8,
    // pageBodies: [
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.lightBlue.shade100,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                Center(
                  child: Form(
                    key: _key,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        // border: Border.all(color: Colors.black.withOpacity(0.2)),
                        border: Border.all(style: BorderStyle.none),
                      ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "COMPLETE PROFILE",
                                style: TextStyle(
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 18
                                      : Responsive.isMobileMedium(context)
                                          ? 19
                                          : Responsive.isMobileLarge(context)
                                              ? 19
                                              : Responsive.isTabletPortrait(
                                                      context)
                                                  ? 24
                                                  : 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(photoURL == ""
                                        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                                        : photoURL),
                                    radius: 90,
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
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Name ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: nameController,
                                readOnly: true,
                                autocorrect: true,
                                style: TextStyle(
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 15
                                      : Responsive.isMobileMedium(context)
                                          ? 17
                                          : Responsive.isMobileLarge(context)
                                              ? 17
                                              : Responsive.isTabletPortrait(
                                                      context)
                                                  ? 20
                                                  : 20,
                                  height: 1.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.isMobileSmall(context)
                                        ? 13
                                        : Responsive.isMobileMedium(context)
                                            ? 15
                                            : Responsive.isMobileLarge(context)
                                                ? 15
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? 17
                                                    : 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.perm_identity,
                                    color: Colors.grey[400],
                                    size: Responsive.isMobileSmall(context)
                                        ? size.width * 0.06
                                        : Responsive.isMobileMedium(context)
                                            ? size.width * 0.06
                                            : Responsive.isMobileLarge(context)
                                                ? size.width * 0.06
                                                : Responsive.isTabletPortrait(
                                                        context)
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
                            ),
                            // SizedBox(height: 10),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     "NIC Type ",
                            //     style: TextStyle(
                            //         fontSize: 15, fontWeight: FontWeight.w500),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 5),
                            //   child: TextFormField(
                            //     controller: nameController,
                            //     readOnly: true,
                            //     autocorrect: true,
                            //     style: TextStyle(
                            //       fontSize: Responsive.isMobileSmall(context)
                            //           ? 15
                            //           : Responsive.isMobileMedium(context)
                            //               ? 17
                            //               : Responsive.isMobileLarge(context)
                            //                   ? 17
                            //                   : Responsive.isTabletPortrait(
                            //                           context)
                            //                       ? 20
                            //                       : 20,
                            //       height: 1.0,
                            //       color: Colors.black,
                            //     ),
                            //     decoration: InputDecoration(
                            //       fillColor: Colors.white,
                            //       filled: true,
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide.none,
                            //           borderRadius: BorderRadius.circular(10)),
                            //     ),
                            //   ),
                            // ),

                            // Column(
                            //   children: [
                            //     RadioListTile(
                            //       activeColor: Colors.blue,
                            //       title: Text("NIC"),
                            //       value: "NIC",
                            //       groupValue: nicType,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           nicType = value.toString();
                            //         });
                            //       },
                            //     ),
                            //     RadioListTile(
                            //       activeColor: Colors.blue,
                            //       title: Text("Driving License"),
                            //       value: "Driving License",
                            //       groupValue: nicType,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           nicType = value.toString();
                            //         });
                            //       },
                            //     ),
                            //     RadioListTile(
                            //       activeColor: Colors.blue,
                            //       title: Text("Passport"),
                            //       value: "Passport",
                            //       groupValue: nicType,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           nicType = value.toString();
                            //         });
                            //       },
                            //     ),
                            //     RadioListTile(
                            //       activeColor: Colors.blue,
                            //       title: Text("TIN"),
                            //       value: "TIN",
                            //       groupValue: nicType,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           nicType = value.toString();
                            //         });
                            //       },
                            //     )
                            //   ],
                            // ),

                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "NIC No",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: nameController,
                                readOnly: true,
                                autocorrect: true,
                                style: TextStyle(
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 15
                                      : Responsive.isMobileMedium(context)
                                          ? 17
                                          : Responsive.isMobileLarge(context)
                                              ? 17
                                              : Responsive.isTabletPortrait(
                                                      context)
                                                  ? 20
                                                  : 20,
                                  height: 1.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      // "NIC / Driving License / Passport / TIN",
                                      "NIC Number",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.isMobileSmall(context)
                                        ? 13
                                        : Responsive.isMobileMedium(context)
                                            ? 15
                                            : Responsive.isMobileLarge(context)
                                                ? 15
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? 17
                                                    : 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.verified_user,
                                    color: Colors.grey[400],
                                    size: Responsive.isMobileSmall(context)
                                        ? size.width * 0.06
                                        : Responsive.isMobileMedium(context)
                                            ? size.width * 0.06
                                            : Responsive.isMobileLarge(context)
                                                ? size.width * 0.06
                                                : Responsive.isTabletPortrait(
                                                        context)
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
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Address ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                maxLines: 1,
                                controller: nameController,
                                readOnly: true,
                                autocorrect: true,
                                style: TextStyle(
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 15
                                      : Responsive.isMobileMedium(context)
                                          ? 17
                                          : Responsive.isMobileLarge(context)
                                              ? 17
                                              : Responsive.isTabletPortrait(
                                                      context)
                                                  ? 20
                                                  : 20,
                                  height: 1.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Address Line 1",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.isMobileSmall(context)
                                        ? 13
                                        : Responsive.isMobileMedium(context)
                                            ? 15
                                            : Responsive.isMobileLarge(context)
                                                ? 15
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? 17
                                                    : 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: Colors.grey[400],
                                    size: Responsive.isMobileSmall(context)
                                        ? size.width * 0.06
                                        : Responsive.isMobileMedium(context)
                                            ? size.width * 0.06
                                            : Responsive.isMobileLarge(context)
                                                ? size.width * 0.06
                                                : Responsive.isTabletPortrait(
                                                        context)
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
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                maxLines: 1,
                                controller: nameController,
                                readOnly: true,
                                autocorrect: true,
                                style: TextStyle(
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 15
                                      : Responsive.isMobileMedium(context)
                                          ? 17
                                          : Responsive.isMobileLarge(context)
                                              ? 17
                                              : Responsive.isTabletPortrait(
                                                      context)
                                                  ? 20
                                                  : 20,
                                  height: 1.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Address Line 2",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.isMobileSmall(context)
                                        ? 13
                                        : Responsive.isMobileMedium(context)
                                            ? 15
                                            : Responsive.isMobileLarge(context)
                                                ? 15
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? 17
                                                    : 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: Colors.grey[400],
                                    size: Responsive.isMobileSmall(context)
                                        ? size.width * 0.06
                                        : Responsive.isMobileMedium(context)
                                            ? size.width * 0.06
                                            : Responsive.isMobileLarge(context)
                                                ? size.width * 0.06
                                                : Responsive.isTabletPortrait(
                                                        context)
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
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                maxLines: 1,
                                controller: nameController,
                                readOnly: true,
                                autocorrect: true,
                                style: TextStyle(
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 15
                                      : Responsive.isMobileMedium(context)
                                          ? 17
                                          : Responsive.isMobileLarge(context)
                                              ? 17
                                              : Responsive.isTabletPortrait(
                                                      context)
                                                  ? 20
                                                  : 20,
                                  height: 1.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Address Line 3",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.isMobileSmall(context)
                                        ? 13
                                        : Responsive.isMobileMedium(context)
                                            ? 15
                                            : Responsive.isMobileLarge(context)
                                                ? 15
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? 17
                                                    : 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: Colors.grey[400],
                                    size: Responsive.isMobileSmall(context)
                                        ? size.width * 0.06
                                        : Responsive.isMobileMedium(context)
                                            ? size.width * 0.06
                                            : Responsive.isMobileLarge(context)
                                                ? size.width * 0.06
                                                : Responsive.isTabletPortrait(
                                                        context)
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
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              child: ElevatedButton(
                                child: Text(
                                  "Complete",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: Responsive.isMobileSmall(context)
                                        ? 15
                                        : Responsive.isMobileMedium(context) ||
                                                Responsive.isMobileLarge(
                                                    context)
                                            ? 17
                                            : Responsive.isTabletPortrait(
                                                    context)
                                                ? 20
                                                : 20,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[900]),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    Responsive.isMobileSmall(context)
                                        ? Size(90, 17)
                                        : Responsive.isMobileMedium(context)
                                            ? Size(120, 50)
                                            : Responsive.isMobileLarge(context)
                                                ? Size(110, 40)
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? Size(120, 30)
                                                    : Size(130, 35),
                                  ),
                                ),
                                onPressed: () {
                                  successfullPopup(
                                    context,
                                    "assets/images/check-mark.png",
                                    "SUCCESS",
                                    "Your account has been successfully created.",
                                    okHandler,
                                    Colors.green[700]!,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ],
                  ),
                )
              ])),
        ),
      ),
    );
  }

  void okHandler() {
    closeDialog(context);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false);
  }
}
