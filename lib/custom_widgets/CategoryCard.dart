
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget{
  final String name;
  final String numberOfWorkers;
  final String imagePath;

  const CategoryCard ({super.key, required this.name , required this.numberOfWorkers, required this.imagePath });
  @override
  Widget build(BuildContext context) {

    return Container(
        height: 140,
        width: 130,
        margin: EdgeInsets.symmetric(vertical: 10),
        child:Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                right: 15,
                child: CircleAvatar(
                  radius: 12,
                  child: Image(image: AssetImage("$imagePath")),

                ),
              ),
              Positioned(
                  bottom: 12,
                  left: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$name", style: TextStyle(color: Colors.blue[900], fontSize: 14, fontWeight: FontWeight.bold),),
                      Text("$numberOfWorkers workers ready", style: TextStyle(color: Colors.grey, fontSize: 12),),
                    ],
                  )),
            ],
          ),

          elevation: 8,
        ) ,

      );

  }

}