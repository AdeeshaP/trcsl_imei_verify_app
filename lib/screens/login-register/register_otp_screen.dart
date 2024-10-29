import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/login_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/registration_screen.dart';

class EmailVerifyOTPScreen extends StatefulWidget {
  const EmailVerifyOTPScreen({super.key});

  @override
  State<EmailVerifyOTPScreen> createState() => _EmailVerifyOTPScreenState();
}

class _EmailVerifyOTPScreenState extends State<EmailVerifyOTPScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
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
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
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
            SizedBox(height: 15),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade100,
                  ),
                  height: Responsive.isMobileSmall(context)
                      ? size.height * 0.7
                      : Responsive.isMobileMedium(context)
                          ? size.height * 0.65
                          : Responsive.isMobileLarge(context)
                              ? size.height * 0.62
                              : Responsive.isTabletPortrait(context)
                                  ? size.width * 0.5
                                  : size.width * 0.25,
                  width: Responsive.isMobileMedium(context)
                      ? size.width * 0.95
                      : Responsive.isTabletPortrait(context)
                          ? size.width * 0.85
                          : size.width * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Verify Your Email",
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
                        // Image.network(
                        //   "https://img.freepik.com/premium-vector/opened-envelope-document-with-green-check-mark-line-icon-official-confirmation-message-mail-sent-successfully-email-delivery-verification-email-flat-design-vector_662353-720.jpg",
                        Image.asset(
                          "assets/images/email_v.png",
                          width: 120,
                          height: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Enter the 4-digit code we just sent to *******@gmail.com.',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: Responsive.isMobileSmall(context)
                                  ? 14
                                  : Responsive.isMobileMedium(context) ||
                                          Responsive.isMobileLarge(context)
                                      ? 15
                                      : Responsive.isTabletPortrait(context)
                                          ? 20
                                          : 21,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _key,
                          child: OtpTextField(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            borderWidth: 1,
                            autoFocus: false,
                            numberOfFields: 4,
                            fieldWidth:
                                Responsive.isMobileSmall(context) ? 45 : 55,
                            fillColor: Colors.transparent,
                            filled: true,
                            borderColor: Colors.blue[900]!,
                            enabled: true,
                            enabledBorderColor: Colors.black54,
                            showFieldAsBox: true,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) {}, //
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15.5
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.lightBlue),
                              minimumSize:
                                  MaterialStateProperty.all(Size(125, 35)),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context) ||
                                        Responsive.isMobileMedium(context)
                                    ? 16
                                    : Responsive.isMobileLarge(context)
                                        ? 17
                                        : Responsive.isTabletPortrait(context)
                                            ? 18
                                            : 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'Didn\'t receive a verification code ? ',
                                  style: TextStyle(height: 1.4),
                                ),
                                TextSpan(
                                  text: 'Resend.',
                                  style: TextStyle(
                                      height: 1.2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: Text(
                              "Change Email",
                              style: TextStyle(
                                fontSize: Responsive.isMobileSmall(context)
                                    ? 14
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? 15.5
                                        : Responsive.isTabletPortrait(context)
                                            ? 17
                                            : 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade400),
                              minimumSize:
                                  MaterialStateProperty.all(Size(125, 35)),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
