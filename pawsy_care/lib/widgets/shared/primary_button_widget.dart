import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButtonWidget extends StatefulWidget {
  final Function() addFunction;
  final String string;

  const PrimaryButtonWidget({required this.addFunction, required this.string, super.key});

  @override
  State<PrimaryButtonWidget> createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: widget.addFunction,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF4f6d7a),
                        borderRadius: BorderRadius.circular(12.0),
                    ), 
                      child: Center(
                        child: Text(
                          widget.string,
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ),
                ),
              ),
            );
  }
}