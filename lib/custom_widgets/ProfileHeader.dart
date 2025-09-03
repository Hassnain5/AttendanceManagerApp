import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String profileImage;
  final Map<String, int> stats;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(profileImage),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(email, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: stats.entries
                .map((entry) => Column(
              children: [
                Text(
                  entry.value.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(entry.key,
                    style:
                    const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ))
                .toList(),
          )
        ],
      ),
    );
  }
}