import 'package:flutter/material.dart';

import 'ProfileMenuItem.dart';


class ProfileMenuSection extends StatelessWidget {
  final String title;
  final List<ProfileMenuItem> items;

  const ProfileMenuSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey))),
          Column(children: items)
        ],
      ),
    );
  }
}