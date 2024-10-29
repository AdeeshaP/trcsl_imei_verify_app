import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trcsl_imei_verify_app/auth-methods/authentication_methods.dart';
import 'package:trcsl_imei_verify_app/screens/home/home_screen.dart';
import 'package:trcsl_imei_verify_app/screens/login-register/registration_screen.dart';
import 'package:trcsl_imei_verify_app/screens/on-boarding/onboarding_one.dart';
import '../../responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  bool _obscureText = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late SharedPreferences _storage;

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _seeOrHidePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  getSharedPref() async {
    _storage = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
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
            SizedBox(height: 10),
            Center(
              child: Form(
                key: _key,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                    child: Column(children: [
                      SizedBox(height: size.width * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "LOGIN",
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
                      usernameTextField(),
                      passwordTextField(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Clear",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? size.width * 0.04
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? size.width * 0.038
                                          : Responsive.isTabletPortrait(context)
                                              ? size.width * 0.03
                                              : size.width * 0.06,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                fixedSize: Responsive.isMobileSmall(context)
                                    ? Size(90, 17)
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? Size(110, 30)
                                        : Responsive.isTabletPortrait(context)
                                            ? Size(120, 30)
                                            : Size(130, 35),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? size.width * 0.042
                                      : Responsive.isMobileMedium(context) ||
                                              Responsive.isMobileLarge(context)
                                          ? size.width * 0.04
                                          : Responsive.isTabletPortrait(context)
                                              ? size.width * 0.03
                                              : size.width * 0.06,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                fixedSize: Responsive.isMobileSmall(context)
                                    ? Size(90, 17)
                                    : Responsive.isMobileMedium(context) ||
                                            Responsive.isMobileLarge(context)
                                        ? Size(110, 30)
                                        : Responsive.isTabletPortrait(context)
                                            ? Size(120, 30)
                                            : Size(130, 35),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => HomePage(),
                                    // builder: (_) => OnboardingProfile(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "OR",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: Responsive.isMobileSmall(context)
                              ? 15
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 17
                                  : Responsive.isTabletPortrait(context)
                                      ? 19
                                      : 22,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Continue With",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: Responsive.isMobileSmall(context)
                              ? 15
                              : Responsive.isMobileMedium(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 17
                                  : Responsive.isTabletPortrait(context)
                                      ? 19
                                      : 22,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var result = await AuthenticationMethods()
                                      .signInWithGoogle();

                                  if (result.user != null) {
                                    print(
                                        "login success >> ${result.user!.email} , ${result.user!.displayName} , ${result.user!.uid}");
                                    print(
                                        "login success >> ${result.user!.photoURL} , ${result.additionalUserInfo!.providerId}");

                                    _storage.setString('username',
                                        (result.user!.displayName)!);
                                    _storage.setString(
                                        'email', (result.user!.email)!);
                                    _storage.setString(
                                        'photoUrl', (result.user!.photoURL)!);
                                    _storage.setString(
                                        'UUID', (result.user!.uid));

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => OnboardingProfile(),
                                      ),
                                    );
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          "Error while login with Google!!"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey.shade200,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: new Center(
                                    widthFactor: 40.0,
                                    heightFactor: 40.0,
                                    child: new Image.asset(
                                        'assets/images/google.png',
                                        width: 40.0,
                                        height: 40.0),
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () async {
                              //     var result = await signInWithFacebook();

                              //     if (result.user != null) {
                              //       print(
                              //           "login success >> ${result.user!.email} , ${result.user!.displayName}");
                              //       print(
                              //           "login success >> ${result.user!.photoURL} , ${result.user!.phoneNumber}");
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (_) =>
                              //               DeviceRegistrationScreen(),
                              //         ),
                              //       );
                              //     } else {
                              //       const snackBar = SnackBar(
                              //         content: Text(
                              //             "Error while login with Google!!"),
                              //       );
                              //       ScaffoldMessenger.of(context)
                              //           .showSnackBar(snackBar);
                              //     }
                              //   },
                              //   child: Container(
                              //     height: 80,
                              //     width: 80,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey.shade200,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: new Center(
                              //       widthFactor: 40.0,
                              //       heightFactor: 40.0,
                              //       child: new Image.asset(
                              //         'assets/images/fb.png',
                              //         width: 40.0,
                              //         height: 40.0,
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              GestureDetector(
                                onTap: () async {
                                  var result = await AuthenticationMethods()
                                      .signInWithApple();
                                  if (result.user != null) {
                                    print(result.user);
                                    print(
                                        "login success >> ${result.user!.email} , ${result.user!.displayName} , ${result.user!.uid}");
                                    print(
                                        "login success >> ${result.user!.providerData}");
                                    _storage.setString('username',
                                        (result.user!.displayName)!);
                                    _storage.setString(
                                        'email', (result.user!.email)!);
                                    _storage.setString(
                                        'photoUrl', (result.user!.photoURL)!);
                                    _storage.setString(
                                        'UUID', (result.user!.uid));

                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (_) =>
                                    //         OnboardingProfile(),
                                    //   ),
                                    // );
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          "Error while login with Google!!"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.grey.shade200,
                                    color: Colors.white,
                                  ),
                                  child: new Center(
                                    widthFactor: 100.0,
                                    heightFactor: 100.0,
                                    child: new Image.asset(
                                      'assets/images/Apple-Logo.png',
                                      width: 100.0,
                                      height: 100.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   child: Column(
                      //     children: [
                      //       SocialLoginButton(
                      //         text: "Sign In with Google",
                      //         height: 45.0,
                      //         buttonType: SocialLoginButtonType.google,
                      //         onPressed: () async {
                      //           var result = await signInWithGoogle();

                      //           if (result.user != null) {
                      //             print(
                      //                 "login success >> ${result.user!.email} , ${result.user!.displayName}");
                      //             print(
                      //                 "login success >> ${result.user!.photoURL} , ${result.user!.phoneNumber}");
                      //             Navigator.of(context).push(
                      //               MaterialPageRoute(
                      //                 builder: (_) =>
                      //                     DeviceRegistrationScreen(),
                      //               ),
                      //             );
                      //           } else {
                      //             const snackBar = SnackBar(
                      //               content:
                      //                   Text("Error while login with Google!!"),
                      //             );
                      //             ScaffoldMessenger.of(context)
                      //                 .showSnackBar(snackBar);
                      //           }
                      //         },
                      //       ),
                      //       const SizedBox(height: 10),
                      //       SocialLoginButton(
                      //         text: "Sign In with Facebook",
                      //         height: 45.0,
                      //         buttonType: SocialLoginButtonType.facebook,
                      //         onPressed: () async {
                      //           var result = await signInWithFacebook();

                      //           if (result.user != null) {
                      //             print(
                      //                 "login success >> ${result.user!.email} , ${result.user!.displayName}");
                      //             print(
                      //                 "login success >> ${result.user!.photoURL} , ${result.user!.phoneNumber}");
                      //             Navigator.of(context).push(
                      //               MaterialPageRoute(
                      //                 builder: (_) =>
                      //                     DeviceRegistrationScreen(),
                      //               ),
                      //             );
                      //           } else {
                      //             const snackBar = SnackBar(
                      //               content: Text(
                      //                   "Error while login with Facebook!!"),
                      //             );
                      //             ScaffoldMessenger.of(context)
                      //                 .showSnackBar(snackBar);
                      //           }
                      //         },
                      //       ),
                      //       const SizedBox(height: 10),
                      //       SocialLoginButton(
                      //         text: "Sign In with Apple",
                      //         height: 45.0,
                      //         buttonType: SocialLoginButtonType.appleBlack,
                      //         onPressed: () async {
                      //           var result = await signInWithApple();

                      //           if (result.user != null) {
                      //             print(
                      //                 "login success >> ${result.user!.email} , ${result.user!.displayName}");
                      //             print(
                      //                 "login success >> ${result.user!.photoURL} , ${result.user!.phoneNumber}");
                      //             Navigator.of(context).push(
                      //               MaterialPageRoute(
                      //                 builder: (_) =>
                      //                     DeviceRegistrationScreen(),
                      //               ),
                      //             );
                      //           } else {
                      //             const snackBar = SnackBar(
                      //               content: Text(
                      //                   "Error while login with Apple ID!!"),
                      //             );
                      //             ScaffoldMessenger.of(context)
                      //                 .showSnackBar(snackBar);
                      //           }
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontSize: Responsive.isMobileSmall(context)
                                  ? 13
                                  : Responsive.isMobileMedium(context) ||
                                          Responsive.isMobileLarge(context)
                                      ? 14.5
                                      : Responsive.isTabletPortrait(context)
                                          ? 16
                                          : 19,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Register Now",
                                style: TextStyle(
                                  fontSize: Responsive.isMobileSmall(context)
                                      ? 13
                                      : Responsive.isMobileMedium(context)
                                          ? 14
                                          : Responsive.isMobileLarge(context)
                                              ? 14.5
                                              : Responsive.isTabletPortrait(
                                                      context)
                                                  ? 16
                                                  : 19,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ]),
        ),
      )),
    );
  }

  Widget usernameTextField() {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
      child: TextFormField(
        controller: usernameController,
        autofocus: false,
        onSaved: (value) {
          usernameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        style: TextStyle(
            fontSize: Responsive.isMobileMedium(context)
                ? size.width * 0.045
                : Responsive.isTabletPortrait(context)
                    ? size.width * 0.028
                    : size.width * 0.045,
            height: Responsive.isMobileMedium(context)
                ? 0.05
                : Responsive.isTabletPortrait(context)
                    ? size.width * 0.001
                    : size.width * 0.005,
            color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          labelText: "Username",
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: Responsive.isMobileSmall(context)
                ? size.width * 0.042
                : Responsive.isMobileMedium(context) ||
                        Responsive.isMobileLarge(context)
                    ? size.width * 0.04
                    : Responsive.isTabletPortrait(context)
                        ? size.width * 0.02
                        : size.width * 0.04,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 40),
          prefixIcon: Icon(
            color: Colors.grey[400],
            Icons.person,
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
          hintText: "Enter the the username",
          hintStyle:
              TextStyle(color: Colors.white60, fontSize: size.width * 0.04),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return ("Username is required..");
          }
          return null;
        },
      ),
    );
  }

  Widget passwordTextField() {
    Size size = MediaQuery.of(context).size;

    return Padding(
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
      child: TextFormField(
        controller: passwordController,
        autofocus: false,
        onSaved: (value) {
          passwordController.text = value!;
          FocusScope.of(context).unfocus();
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscureText,
        style: TextStyle(
            fontSize: Responsive.isMobileSmall(context) ||
                    Responsive.isMobileMedium(context) ||
                    Responsive.isMobileLarge(context)
                ? size.width * 0.045
                : Responsive.isTabletPortrait(context)
                    ? size.width * 0.028
                    : size.width * 0.045,
            height: Responsive.isMobileMedium(context)
                ? 0.05
                : Responsive.isTabletPortrait(context)
                    ? size.width * 0.001
                    : size.width * 0.005,
            color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: Responsive.isMobileSmall(context)
                ? size.width * 0.042
                : Responsive.isMobileMedium(context) ||
                        Responsive.isMobileLarge(context)
                    ? size.width * 0.04
                    : Responsive.isTabletPortrait(context)
                        ? size.width * 0.02
                        : size.width * 0.04,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 40),
          prefixIcon: Icon(
            color: Colors.grey[400],
            Icons.lock,
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
          suffixIcon: IconButton(
            color: Colors.grey[400],
            onPressed: _seeOrHidePassword,
            icon: Icon(
              _obscureText == true ? Icons.visibility_off : Icons.visibility,
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
          ),
          hintText: "Enter the password",
          hintStyle: TextStyle(color: Colors.white60, fontSize: 15),
        ),
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Password is required.");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 3 Character)");
          }
          return null;
        },
      ),
    );
  }
}
