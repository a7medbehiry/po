import 'package:flutter/material.dart';


class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton(
      {super.key,
      required this.image,
      required this.title,
      required this.onPressed});
  final String image, title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0xFFDCDEDE),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: ListTile(
          visualDensity: const VisualDensity(
            vertical: VisualDensity.minimumDensity,
          ),
          leading: Image.asset(image),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }
}