import 'package:flutter/material.dart';
import 'package:newsapp/utilities/constants/colors.dart';

TextField searchField({onChanged, controller, hintText}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: PColors.backgrounColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: PColors.backgrounColor, width: 1.0),
        ),
        prefixIcon: const Icon(Icons.search),
        hintText: hintText),
  );
}
