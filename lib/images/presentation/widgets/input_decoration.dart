import 'package:flutter/material.dart';

InputDecoration getInputDecoration(String hintext, IconData iconData) {
  return InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    filled: true,
    prefixIcon: Icon(
      iconData,
      color: Colors.black38,
    ),
    hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
    hintText: hintext,
    fillColor: const Color(0xFFF5F9FA),
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
  );
}
