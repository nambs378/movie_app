import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';

class PasswordInput extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextInputAction inputAction;
  final double height;

  const PasswordInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.inputAction,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[600]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
            hintStyle: sTextWhite,
          ),
          obscureText: true,
          style: sTextWhite,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
