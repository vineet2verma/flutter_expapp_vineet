import 'package:flutter/material.dart';

class CustomeElevatedButton extends StatelessWidget {

  final String name;
  final Color btnColor;
  final Color textColor;
  final VoidCallback onTap;
  final Widget? widget;

  const CustomeElevatedButton({super.key, required this.name,required this.btnColor,
    required this.textColor, required this.onTap, this.widget });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: btnColor),
        child: widget ?? Text(name, style: TextStyle(fontSize: 18, color: textColor),),
    ),
    );
  }
}
