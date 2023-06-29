// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final icon;
  final text;
  final VoidCallback onTap;

  const ListTileWidget({super.key, required this.icon, required this.text, required this.onTap,});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(icon),
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_sharp),
          ],
        ),
      ),
    );
  }
}
