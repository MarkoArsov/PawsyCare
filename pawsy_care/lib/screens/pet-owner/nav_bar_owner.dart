import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pawsy_care/controllers/nav_bar_controller.dart';

class NavBarOwner extends StatelessWidget {
  const NavBarOwner({super.key});

  @override
  Widget build(BuildContext context) {
    NavBarController navBarController = Get.put(NavBarController());

    return Scaffold(
        bottomNavigationBar: Container(
          color: const Color(0xFF4f6d7a),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: GNav(
              backgroundColor: const Color(0xFF4f6d7a),
              color: Colors.white,
              activeColor: const Color(0xFF4f6d7a),
              tabBackgroundColor: Colors.grey[200]!,
              gap: 8,
              onTabChange: (index) {
                navBarController.selectedIndex.value = index;
              },
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(icon: Icons.pets, text: 'Pets'),
                GButton(icon: Icons.book, text: 'Services'),
                GButton(icon: Icons.map, text: 'Locations'),
                GButton(icon: Icons.calendar_month, text: 'Bookings'),
              ],
            ),
          ),
        ),
        body: Obx(
          () => navBarController.pages[navBarController.selectedIndex.value],
        ));
  }
}
