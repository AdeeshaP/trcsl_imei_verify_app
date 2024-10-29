import 'dart:io';
import 'package:device_imei/device_imei.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trcsl_imei_verify_app/components/dialogs.dart';
import 'package:trcsl_imei_verify_app/providers/provider.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';
import 'package:trcsl_imei_verify_app/screens/notifications/notifications.dart';
import 'package:trcsl_imei_verify_app/screens/profile/user_profile.dart';
import 'package:trcsl_imei_verify_app/screens/scanner/reader_scareen.dart';
import 'package:trcsl_imei_verify_app/screens/scanner/scan_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trcsl_imei_verify_app/screens/apprval-summary/approval_summary_screen.dart';
import 'package:trcsl_imei_verify_app/screens/about_us.dart';
import 'package:trcsl_imei_verify_app/screens/contact_us.dart';
import 'package:trcsl_imei_verify_app/screens/help/help_screen.dart';

class DeviceRegistrationScreen extends StatefulWidget {
  const DeviceRegistrationScreen({super.key});

  @override
  State<DeviceRegistrationScreen> createState() =>
      _DeviceRegistrationScreenState();
}

class _DeviceRegistrationScreenState extends State<DeviceRegistrationScreen> {
  final TextEditingController imeiController = TextEditingController(text: "");
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? deviceImei;
  String? type;
  String message = "Please allow permission request!";
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  bool isloading = false;
  String result = "";
  // String inputType = "Input IMEI";
  bool showContainer = false;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  int? selectedBarcode;
  bool isScanOptionSelected = false;
  List<int> barcodeValues = [];
  int numberOfIMEIs = 5;

  @override
  void initState() {
    super.initState();
    ScanProvider scanProvider =
        Provider.of<ScanProvider>(context, listen: false);

    barcodeValues = scanProvider.results.values
        .where((element) => element.barcodeText.length == 15)
        .map((e) => int.parse(e.barcodeText))
        .toList();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceGeneralData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceGeneralData =
            _readAndroidGeneraldData(await deviceInfoPlugin.androidInfo);
      }

      setState(() {
        _deviceData = deviceGeneralData;
      });
    } on PlatformException {
      deviceGeneralData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  Map<String, dynamic> _readAndroidGeneraldData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'Device Id': build.id,
      'Device Brand': build.brand,
      'Device': build.device,
      'Device Model': build.model,
      'Product': build.product,
      'Android Version': build.version.release,
      'API Level': build.version.sdkInt,
    };
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
    final scanProvider2 = Provider.of<ScanProvider2>(context);

    return SafeArea(
        child: Scaffold(
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
            "Device Registration",
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
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
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
                    border: Border.all(style: BorderStyle.none),
                  ),
                  height: Responsive.isMobileSmall(context)
                      ? size.height * 0.55
                      : Responsive.isMobileMedium(context) ||
                              Responsive.isMobileLarge(context)
                          ? size.height * 0.6
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
                    child: Column(children: [
                      SizedBox(height: size.width * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "DEVICE REGISTRATION",
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
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text('Input IMEI'),
                            leading: Radio(
                              activeColor: Colors.blue,
                              value: "Input IMEI",
                              // groupValue: inputType,
                              groupValue:
                                  Provider.of<ScanProvider2>(context).inputType,
                              onChanged: (value) {
                                // setState(() {
                                //   inputType = value!;
                                //   showContainer = false;
                                // });

                                // debugPrint(inputType);
                                // Assuming you have a provider instance available here. If not, obtain it as shown below.
                                final scanProvider = Provider.of<ScanProvider2>(
                                    context,
                                    listen: false);
                                scanProvider.setInputType(value!);
                                setState(() {
                                  showContainer = false;
                                });
                                debugPrint(value);
                              },
                            ),
                          )),
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text('Scan IMEI'),
                              leading: Radio(
                                activeColor: Colors.blue,
                                value: "Scan IMEI",
                                // groupValue: inputType,
                                groupValue: Provider.of<ScanProvider2>(context)
                                    .inputType,
                                onChanged: (value) {
                                  // setState(() {
                                  //   inputType = value!;
                                  //   showContainer = false;
                                  // });

                                  // debugPrint(inputType);
                                  // Assuming you have a provider instance available here. If not, obtain it as shown below.
                                  final scanProvider2 =
                                      Provider.of<ScanProvider2>(context,
                                          listen: false);
                                  scanProvider2.setInputType(value!);
                                  setState(() {
                                    showContainer = false;
                                  });
                                  debugPrint(value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (scanProvider2.inputType == "Input IMEI")
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isMobileSmall(context) ||
                                    Responsive.isMobileMedium(context) ||
                                    Responsive.isMobileLarge(context)
                                ? 8.0
                                : Responsive.isTabletPortrait(context)
                                    ? size.width * 0.02
                                    : size.width * 0.04,
                            vertical: Responsive.isMobileSmall(context) ||
                                    Responsive.isMobileMedium(context) ||
                                    Responsive.isMobileLarge(context)
                                ? 5.0
                                : Responsive.isTabletPortrait(context)
                                    ? size.width * 0.01
                                    : size.width * 0.02,
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: imeiController,
                                autofocus: false,
                                onSaved: (value) {
                                  imeiController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontSize: Responsive.isMobileSmall(
                                                context) ||
                                            Responsive.isMobileMedium(
                                                context) ||
                                            Responsive.isMobileLarge(context)
                                        ? size.width * 0.045
                                        : Responsive.isTabletPortrait(context)
                                            ? size.width * 0.028
                                            : size.width * 0.045,
                                    height: Responsive.isMobileSmall(context) ||
                                            Responsive.isMobileMedium(
                                                context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 0.05
                                        : Responsive.isTabletPortrait(context)
                                            ? size.width * 0.001
                                            : size.width * 0.005,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: "Type Device IMEI",
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: Responsive.isMobileSmall(context)
                                        ? size.width * 0.042
                                        : Responsive.isMobileMedium(context) ||
                                                Responsive.isMobileLarge(
                                                    context)
                                            ? size.width * 0.04
                                            : Responsive.isTabletPortrait(
                                                    context)
                                                ? size.width * 0.02
                                                : size.width * 0.04,
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 40),
                                  prefixIcon: Icon(
                                    color: Colors.grey[400],
                                    Icons.device_unknown,
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
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("IMEI is required..");
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        imeiController.clear();
                                      },
                                      child: Text(
                                        "Clear",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Responsive.isMobileSmall(
                                                  context)
                                              ? size.width * 0.042
                                              : Responsive.isMobileMedium(
                                                          context) ||
                                                      Responsive.isMobileLarge(
                                                          context)
                                                  ? size.width * 0.04
                                                  : Responsive.isTabletPortrait(
                                                          context)
                                                      ? size.width * 0.03
                                                      : size.width * 0.06,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey[500]),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                          Responsive.isMobileSmall(context)
                                              ? Size(120, 35)
                                              : Responsive.isMobileMedium(
                                                          context) ||
                                                      Responsive.isMobileLarge(
                                                          context)
                                                  ? Size(130, 40)
                                                  : Responsive.isTabletPortrait(
                                                          context)
                                                      ? Size(150, 40)
                                                      : Size(160, 50),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          // Toggle the state to show/hide the container
                                          showContainer = !showContainer;
                                        });
                                      },
                                      child: Text(
                                        "Get IMEI",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Responsive.isMobileSmall(
                                                  context)
                                              ? size.width * 0.042
                                              : Responsive.isMobileMedium(
                                                          context) ||
                                                      Responsive.isMobileLarge(
                                                          context)
                                                  ? size.width * 0.04
                                                  : Responsive.isTabletPortrait(
                                                          context)
                                                      ? size.width * 0.03
                                                      : size.width * 0.06,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue[900]),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                          Responsive.isMobileSmall(context)
                                              ? Size(120, 35)
                                              : Responsive.isMobileMedium(
                                                          context) ||
                                                      Responsive.isMobileLarge(
                                                          context)
                                                  ? Size(130, 40)
                                                  : Responsive.isTabletPortrait(
                                                          context)
                                                      ? Size(150, 40)
                                                      : Size(160, 50),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                    icon: Icon(Icons.qr_code_scanner),
                                    iconSize: 50,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ReaderScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(11, 1, 11, 5),
                                      child: DropdownButton(
                                        underline: Container(),
                                        isExpanded: true,
                                        hint: Text(
                                          "IMEI Number",
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: Responsive.isMobileSmall(
                                                    context)
                                                ? size.width * 0.030
                                                : Responsive.isMobileMedium(
                                                            context) ||
                                                        Responsive
                                                            .isMobileLarge(
                                                                context)
                                                    ? size.width * 0.035
                                                    : Responsive
                                                            .isTabletPortrait(
                                                                context)
                                                        ? size.width * 0.018
                                                        : size.width * 0.016,
                                          ),
                                        ),
                                        value: selectedBarcode,
                                        items: barcodeValues.map((item) {
                                          return DropdownMenuItem(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                item.toString(),
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: Responsive
                                                              .isMobileSmall(
                                                                  context) ||
                                                          Responsive
                                                              .isMobileMedium(
                                                                  context) ||
                                                          Responsive
                                                              .isMobileLarge(
                                                                  context)
                                                      ? size.width * 0.04
                                                      : Responsive
                                                              .isTabletPortrait(
                                                                  context)
                                                          ? size.width * 0.018
                                                          : size.width * 0.012,
                                                ),
                                              ),
                                            ),
                                            value: item,
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedBarcode = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (barcodeValues.length == 0) {
                                      } else {
                                        setState(() {
                                          // Toggle the state to show/hide the container
                                          showContainer = !showContainer;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Get IMEI",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Responsive.isMobileSmall(
                                                context)
                                            ? size.width * 0.042
                                            : Responsive.isMobileMedium(
                                                        context) ||
                                                    Responsive.isMobileLarge(
                                                        context)
                                                ? size.width * 0.04
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? size.width * 0.03
                                                    : size.width * 0.06,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              barcodeValues.length == 0
                                                  ? Colors.grey
                                                  : Colors.blue[900]),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      fixedSize: MaterialStateProperty.all(
                                        Responsive.isMobileSmall(context)
                                            ? Size(120, 35)
                                            : Responsive.isMobileMedium(
                                                        context) ||
                                                    Responsive.isMobileLarge(
                                                        context)
                                                ? Size(130, 40)
                                                : Responsive.isTabletPortrait(
                                                        context)
                                                    ? Size(150, 40)
                                                    : Size(160, 50),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (showContainer)
                        Container(
                          width: size.width,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Company',
                                      style: TextStyle(
                                          fontSize: Responsive.isMobileSmall(
                                                  context)
                                              ? 12
                                              : Responsive.isMobileMedium(
                                                      context)
                                                  ? 14
                                                  : Responsive.isMobileLarge(
                                                          context)
                                                      ? 15
                                                      : Responsive
                                                              .isTabletPortrait(
                                                                  context)
                                                          ? 17
                                                          : 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      _deviceData["Device Brand"],
                                      style: TextStyle(
                                          fontSize: Responsive.isMobileSmall(
                                                  context)
                                              ? 12
                                              : Responsive.isMobileMedium(
                                                      context)
                                                  ? 14
                                                  : Responsive.isMobileLarge(
                                                          context)
                                                      ? 15
                                                      : Responsive
                                                              .isTabletPortrait(
                                                                  context)
                                                          ? 17
                                                          : 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Model',
                                      style: TextStyle(
                                        fontSize: Responsive.isMobileSmall(
                                                context)
                                            ? 12
                                            : Responsive.isMobileMedium(context)
                                                ? 14
                                                : Responsive.isMobileLarge(
                                                        context)
                                                    ? 15
                                                    : Responsive
                                                            .isTabletPortrait(
                                                                context)
                                                        ? 17
                                                        : 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      _deviceData["Device Model"],
                                      style: TextStyle(
                                        fontSize: Responsive.isMobileSmall(
                                                context)
                                            ? 12
                                            : Responsive.isMobileMedium(context)
                                                ? 14
                                                : Responsive.isMobileLarge(
                                                        context)
                                                    ? 15
                                                    : Responsive
                                                            .isTabletPortrait(
                                                                context)
                                                        ? 17
                                                        : 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Android Version',
                                      style: TextStyle(
                                        fontSize: Responsive.isMobileSmall(
                                                context)
                                            ? 12
                                            : Responsive.isMobileMedium(context)
                                                ? 14
                                                : Responsive.isMobileLarge(
                                                        context)
                                                    ? 15
                                                    : Responsive
                                                            .isTabletPortrait(
                                                                context)
                                                        ? 17
                                                        : 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      _deviceData["Android Version"].toString(),
                                      style: TextStyle(
                                        fontSize: Responsive.isMobileSmall(
                                                context)
                                            ? 13
                                            : Responsive.isMobileMedium(context)
                                                ? 15
                                                : Responsive.isMobileLarge(
                                                        context)
                                                    ? 15
                                                    : Responsive
                                                            .isTabletPortrait(
                                                                context)
                                                        ? 17
                                                        : 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      'API Level',
                                      style: TextStyle(
                                          fontSize: Responsive.isMobileSmall(
                                                  context)
                                              ? 12
                                              : Responsive.isMobileMedium(
                                                      context)
                                                  ? 14
                                                  : Responsive.isMobileLarge(
                                                          context)
                                                      ? 15
                                                      : Responsive
                                                              .isTabletPortrait(
                                                                  context)
                                                          ? 17
                                                          : 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      _deviceData["API Level"].toString(),
                                      style: TextStyle(
                                          fontSize: Responsive.isMobileSmall(
                                                  context)
                                              ? 12
                                              : Responsive.isMobileMedium(
                                                      context)
                                                  ? 14
                                                  : Responsive.isMobileLarge(
                                                          context)
                                                      ? 15
                                                      : Responsive
                                                              .isTabletPortrait(
                                                                  context)
                                                          ? 17
                                                          : 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      'IMEI Number',
                                      style: TextStyle(
                                        fontSize: Responsive.isMobileSmall(
                                                context)
                                            ? 12
                                            : Responsive.isMobileMedium(context)
                                                ? 14
                                                : Responsive.isMobileLarge(
                                                        context)
                                                    ? 15
                                                    : Responsive
                                                            .isTabletPortrait(
                                                                context)
                                                        ? 17
                                                        : 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      selectedBarcode.toString(),
                                      style: TextStyle(
                                        fontSize: Responsive.isMobileSmall(
                                                context)
                                            ? 12
                                            : Responsive.isMobileMedium(context)
                                                ? 14
                                                : Responsive.isMobileLarge(
                                                        context)
                                                    ? 15
                                                    : Responsive
                                                            .isTabletPortrait(
                                                                context)
                                                        ? 17
                                                        : 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      if (showContainer)
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                fixedSize: Responsive.isMobileSmall(context)
                                    ? Size(90, 17)
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? Size(120, 30)
                                        : Responsive.isTabletPortrait(context)
                                            ? Size(120, 30)
                                            : Size(130, 35),
                              ),
                              onPressed: () {
                                if (numberOfIMEIs == 5) {
                                  showIMEICountExceedPopup(
                                    context,
                                    Icons.error_outline_outlined,
                                    "Oops!",
                                    "It seems you have reached the maximum device registration limit for this app. \n\n Only 5 devices are allowed per user.",
                                    okButton,
                                  );
                                } else {}
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? size.width * 0.04
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? size.width * 0.038
                                          : Responsive.isTabletPortrait(context)
                                              ? size.width * 0.03
                                              : size.width * 0.06,
                                ),
                              )),
                        ),

                      SizedBox(
                        height: 10,
                      ),

                      // getPhoneDetails(size, context),
                    ]),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }

  void okButton() {
    closeDialog(context);
  }

  Column getPhoneDetails(Size size, BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          width: size.width * 0.9,
          height: size.height * 0.3,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Submit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.isMobileSmall(context)
                    ? size.width * 0.042
                    : Responsive.isMobileMedium(context) ||
                            Responsive.isMobileLarge(context)
                        ? size.width * 0.04
                        : Responsive.isTabletPortrait(context)
                            ? size.width * 0.03
                            : size.width * 0.06,
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              fixedSize: MaterialStateProperty.all(
                Responsive.isMobileSmall(context)
                    ? Size(120, 35)
                    : Responsive.isMobileMedium(context) ||
                            Responsive.isMobileLarge(context)
                        ? Size(140, 40)
                        : Responsive.isTabletPortrait(context)
                            ? Size(150, 40)
                            : Size(160, 50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
