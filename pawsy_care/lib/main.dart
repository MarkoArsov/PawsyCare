import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawsy_care/screens/pet-owner/book_services_screen.dart';
import 'package:pawsy_care/screens/pet-owner/create_pet_screen.dart';
import 'package:pawsy_care/screens/pet-owner/pet_list_screen.dart';
import 'package:pawsy_care/screens/pet-owner/pet_owner_calendar_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_list_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_provider_calendar_screen.dart';
import 'package:pawsy_care/screens/shared/auth_screen.dart';
import 'package:pawsy_care/screens/shared/role_select_screen.dart';
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
        '/service-provider-calendar': (context) =>
            const ServiceProviderCalendarScreen(),
        '/pet-list': (context) => const PetListScreen(),
        '/create-pet': (context) => const CreatePetScreen(),
        '/pet-owner-calendar': (context) => const PetOwnerCalendarScreen(),
        '/book-services': (context) => const BookServicesScreen()
      },
    );
  }
}
