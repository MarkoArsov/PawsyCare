import 'package:get/get.dart';
import 'package:pawsy_care/screens/pet-owner/book_services_screen.dart';
import 'package:pawsy_care/screens/pet-owner/pet_list_screen.dart';
import 'package:pawsy_care/screens/pet-owner/pet_owner_calendar_screen.dart';
import 'package:pawsy_care/screens/pet-owner/pet_owner_profile_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_list_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_provider_calendar_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_provider_map_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_provider_profile_screen.dart';

class NavBarController extends GetxController {
  var selectedIndex = 0.obs;

  var pages = [
    const PetListScreen(),
    const BookServicesScreen(),
    const PetOwnerCalendarScreen(),
    const PetOwnerProfileScreen()
  ];

  var pagesProvider = [
    const ServiceListScreen(),
    const ServiceProviderMapScreen(),
    const ServiceProviderCalendarScreen(),
    const ServiceProviderProfileScreen()
  ];
}
