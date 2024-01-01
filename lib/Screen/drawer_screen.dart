import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DrawerScreen extends StatefulWidget {
  List<String>? radioList;
  DrawerScreen({required this.radioList});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  // const DrawerScreen({super.key});

  static bool switchVal = false;

  @override
  Widget build(BuildContext context) {
    // radio Button
    String radioCurrOption = widget.radioList![0];
    var size = MediaQuery.of(context).size;
    return

  }


}
