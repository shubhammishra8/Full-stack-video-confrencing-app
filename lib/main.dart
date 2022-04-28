import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:confrence/resources/auth_methods.dart';
import 'package:confrence/screens/login_screen.dart';
import 'package:confrence/screens/home_screen.dart';
import 'package:confrence/screens/video_call_screen.dart';
import 'package:confrence/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDpkQmXGz1U1T6yajPyyRADLLwmrnpqI60',
        authDomain: 'zoomcloneflutt.firebaseapp.com',
        storageBucket: 'zoomcloneflutt.appspot.com',
        appId: '1:653490324779:web:56504073c13e068a0bf16e',
        messagingSenderId: '653490324779',
        projectId: 'zoomcloneflutt',
        measurementId: 'G-EYF8EKP2EQ',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const ZoomClone());
}

class ZoomClone extends StatelessWidget {
  const ZoomClone({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone Flutter',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/video-call': (context) => const VideoCallScreen(),
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
