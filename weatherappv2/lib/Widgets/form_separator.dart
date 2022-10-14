import 'package:flutter/material.dart';

class FormSeparator {

  static Widget buildSeparator(String title) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(title, style: const TextStyle(fontSize: 18, color: Colors.grey)),
    );
  }

}