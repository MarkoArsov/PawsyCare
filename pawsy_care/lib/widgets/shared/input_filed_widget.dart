import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

  const InputFieldWidget({
    required this.controller,
    this.obscureText = false,
    required this.hintText,
    super.key});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Color(0xFF4f6d7a),
                    width: 1.0,
                  ),
                    borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: widget.controller,
                    obscureText: widget.obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: Color(0xFF4f6d7a),
                      ),
                    ),
                  ),
                ),
              ),
            );
  }
}