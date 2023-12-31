import 'package:flutter/material.dart';

Widget CustomButton({
  required String text,
  required Function onPressed,
  required Color buttonColor,
  required AnimationController controller,
}) {
  return InkWell(
    onTap: () {
      onPressed();
    },
    child: Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
