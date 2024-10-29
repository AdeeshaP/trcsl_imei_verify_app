import 'dart:async';
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen();

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initLicense();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  Future<void> _initLicense() async {
    try {
      await DCVBarcodeReader.initLicense(
          'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          return;
        }
        SystemNavigator.pop();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.lightBlue.shade100,
          body: Container(
            width: size.width,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 150),
                Text(
                  "WELCOME",
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    fontSize: Responsive.isMobileSmall(context)
                        ? 18
                        : Responsive.isMobileMedium(context) ||
                                Responsive.isMobileLarge(context)
                            ? 20
                            : 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/trcsl.png",
                    width: 300,
                    height: 300,
                  ),
                ),
                Text(
                  "Version " + "0.0.1",
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    fontSize: Responsive.isMobileSmall(context)
                        ? 18
                        : Responsive.isMobileMedium(context) ||
                                Responsive.isMobileLarge(context)
                            ? 20
                            : 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  "Powered by Auradot (Pvt) Ltd.",
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    fontSize: Responsive.isMobileSmall(context)
                        ? 14
                        : Responsive.isMobileMedium(context)
                            ? 16
                            : Responsive.isMobileLarge(context)
                                ? 17
                                : 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        ),
      ),
    );
  }
}
