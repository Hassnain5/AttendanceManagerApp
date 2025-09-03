import 'package:flutter/material.dart';

class AttendenceCategory extends StatelessWidget{
  final String imagePath;
  final String title;
  const AttendenceCategory({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Image.asset(imagePath, height: 50, width: 50),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
