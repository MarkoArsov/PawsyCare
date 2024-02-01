import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawsy_care/screens/auth_screen.dart';
import 'package:pawsy_care/screens/pets/pet_list_screen.dart';
import 'package:pawsy_care/screens/role_select_screen.dart';
import 'package:pawsy_care/screens/services/service_list_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const AuthScreen(isLogin: true),
        '/register': (context) => const AuthScreen(isLogin: false),
        '/role': (context) => const RoleScreen(),
        '/service-list': (context) => const ServiceListScreen(),
        '/pet-list': (context) => const PetListScreen(),
      },
    );
  }
}
