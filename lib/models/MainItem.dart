

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainItem extends StatelessWidget{
  final String title;
  final String image;

  const MainItem({super.key , required this.title , required this.image} );


  @override
  Widget build(BuildContext context) {
 return Container(
   decoration: BoxDecoration(
     image: DecorationImage(image: AssetImage(image),
     fit: BoxFit.cover,
       colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken)
     ),

     borderRadius: BorderRadius.circular(15)
   ),
   alignment: Alignment.center,
   child: Text(title ,
   style: const TextStyle(
     color: Colors.white,
     fontWeight: FontWeight.bold,
     fontSize: 18,

   ),
     textAlign: TextAlign.center,
   ),
 );
  }

}