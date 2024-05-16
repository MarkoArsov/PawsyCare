import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pawsy_care/screens/pet-owner/book_services_screen.dart';
import 'package:pawsy_care/screens/pet-owner/pet_list_screen.dart';
import 'package:pawsy_care/screens/pet-owner/pet_owner_calendar_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_list_screen.dart';
import 'package:pawsy_care/screens/service-provider/service_provider_calendar_screen.dart';

class NavBarController extends GetxController {
  var selectedIndex = 0.obs;

  // void updateIndex(int index) {
  //   selectedIndex.value = index;
  // }

  var pages = [
    PetListScreen(),
    BookServicesScreen(),
    PetOwnerCalendarScreen(),
  ];

  var pagesProvider = [
    ServiceListScreen(),
    ServiceProviderCalendarScreen(),
  ];
}