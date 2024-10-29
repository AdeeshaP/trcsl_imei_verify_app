import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trcsl_imei_verify_app/firebase_options.dart';
import 'package:trcsl_imei_verify_app/landing_screen.dart';
import 'package:trcsl_imei_verify_app/providers/provider.dart';
import 'package:trcsl_imei_verify_app/screens/scanner/scan_provider.dart';
import 'package:trcsl_imei_verify_app/screens/scanner/switch_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ScanProvider2()),
      ChangeNotifierProvider(create: (_) => SwitchProvider()),
      ChangeNotifierProvider(create: (_) => ScanProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TRCSL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LandingScreen(),
    );
  }
}
