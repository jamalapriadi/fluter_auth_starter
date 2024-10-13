// import 'package:customer/pages/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages/routes.dart';
import 'pages/splash.dart';

void main() async {
  // HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName:".env");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter APP',
      home: Splash(),
      // home: NotificationPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
