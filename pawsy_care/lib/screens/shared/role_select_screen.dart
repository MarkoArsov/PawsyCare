import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawsy_care/widgets/shared/primary_button_widget.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 240, 247), 
        title: Center(
          child: Text(
            "            Select Role",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 240, 240, 247),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // service provider
            GestureDetector(
              onTap: ()
              {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/service-provider');
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF4f6d7a),
                        borderRadius: BorderRadius.circular(12.0),
                    ), 
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.content_cut, // Replace with your desired icon
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "service provider",
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // pet owner
            GestureDetector(
              onTap: ()
              {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/pet-owner');
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF4f6d7a),
                        borderRadius: BorderRadius.circular(12.0),
                    ), 
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pets_rounded, // Replace with your desired icon
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "pet owner",
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
