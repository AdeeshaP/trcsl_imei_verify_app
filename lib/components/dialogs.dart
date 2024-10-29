import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trcsl_imei_verify_app/responsive.dart';

successfullPopup(BuildContext context, String imagePath, String title,
    String message, Function okHandler, Color color) {
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.black12)),
      ),
    ),
    onPressed: () {
      okHandler();
    },
  );

  // show the dialog
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.45,
          padding: EdgeInsets.fromLTRB(30, 15, 30, 10),
          color: Color.fromARGB(255, 218, 216, 216),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 15),
              Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.green[700],
                  height: 1.5,
                  fontSize: 22,
                  fontFamily: "open sans",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                message,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.green[800],
                    height: 1.5,
                    fontSize: 19,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100,
                  child: okButton,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

closeDialog(context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

// -------------- IMEI count Validation Popup ----------------//
showIMEICountExceedPopup(BuildContext context, IconData icon, String title,
    String message, Function okHandler) {
  Size size = MediaQuery.of(context).size;
  // Setup OK Button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(
        fontSize: Responsive.isMobileSmall(context) ||
                Responsive.isMobileMedium(context) ||
                Responsive.isMobileLarge(context)
            ? 14
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
      backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
    ),
    onPressed: () {
      okHandler();
    },
  );

  // show the dialog
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).alertDialogLabel,
    barrierColor: Colors.black45,
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          width: Responsive.isMobileSmall(context) ||
                  Responsive.isMobileMedium(context) ||
                  Responsive.isMobileLarge(context)
              ? size.width * 0.8
              : Responsive.isTabletPortrait(context)
                  ? size.width * 0.7
                  : size.width * 0.6,
          height: Responsive.isMobileSmall(context)
              ? 340
              : Responsive.isMobileMedium(context)
                  ? 360
                  : Responsive.isMobileLarge(context)
                      ? 370
                      : Responsive.isTabletPortrait(context)
                          ? 500
                          : 500,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.red,
                size: Responsive.isMobileSmall(context)
                    ? 35
                    : Responsive.isMobileMedium(context) ||
                            Responsive.isMobileLarge(context)
                        ? 45
                        : Responsive.isTabletPortrait(context)
                            ? 35
                            : 30,
              ),
              SizedBox(
                height: Responsive.isMobileSmall(context) ||
                        Responsive.isMobileMedium(context) ||
                        Responsive.isMobileLarge(context)
                    ? 10
                    : Responsive.isTabletPortrait(context)
                        ? 20
                        : 25,
              ),
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  fontSize: Responsive.isMobileMedium(context) ||
                          Responsive.isMobileLarge(context)
                      ? 25
                      : Responsive.isTabletPortrait(context)
                          ? 35
                          : 30,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(254, 244, 67, 54),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Responsive.isMobileSmall(context) ||
                        Responsive.isMobileMedium(context) ||
                        Responsive.isMobileLarge(context)
                    ? 20
                    : Responsive.isTabletPortrait(context)
                        ? 35
                        : 30,
              ),
              Text(
                message,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                  fontSize: Responsive.isMobileSmall(context)
                      ? 15
                      : Responsive.isMobileMedium(context)
                          ? 16
                          : Responsive.isMobileLarge(context)
                              ? 17
                              : Responsive.isTabletPortrait(context)
                                  ? 24
                                  : 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: Responsive.isMobileMedium(context) ||
                        Responsive.isMobileLarge(context)
                    ? 25
                    : Responsive.isTabletPortrait(context)
                        ? 35
                        : 32,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: Responsive.isMobileSmall(context) ||
                          Responsive.isMobileMedium(context) ||
                          Responsive.isMobileLarge(context)
                      ? size.width * 0.3
                      : Responsive.isTabletPortrait(context)
                          ? size.width * 0.3
                          : size.width * 0.25,
                  height: Responsive.isMobileSmall(context) ||
                          Responsive.isMobileMedium(context) ||
                          Responsive.isMobileLarge(context)
                      ? 35
                      : Responsive.isTabletPortrait(context)
                          ? 40
                          : 38,
                  child: okButton,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
