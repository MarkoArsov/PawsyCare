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
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xFF4f6d7a),
            gap: 8,
            onTabChange: (index) {
              print(index);
              navBarController.selectedIndex.value = index;
            },
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(icon: Icons.pets, text: 'Pets'),
              GButton(icon: Icons.home, text: 'Services'),
              GButton(icon: Icons.calendar_month, text: 'Bookings'),
              GButton(icon: Icons.person, text: 'Account'),
            ],
          ),
        ),
      ),
      body: Obx(
      () => navBarController.pages[navBarController.selectedIndex.value],
      ));
  }
}
