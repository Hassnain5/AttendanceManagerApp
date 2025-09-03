
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendedCard extends StatelessWidget{
  final String imagePath;
  final String personName;
  final String workType;
  final double rating;
  final double price;
  final int number;

  const RecommendedCard({super.key , required this.imagePath, required this.personName, required this.rating, required this.price, required this.number, required this.workType});
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 210,
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(10),
         border: Border.all(
          color: Colors.grey[400]!,
              width: 1
      )
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: AssetImage(imagePath) ,width: 180,height: 100, fit: BoxFit.cover),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(personName, style:TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),),
                      Row(
                        children: [

                          Icon(Icons.star, color: Colors.yellow[700],),
                          Text(rating.toString(), style:TextStyle(color: Colors.indigo[700], fontSize: 15,),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,

                  ),
                  Text(workType, style:TextStyle(color: Colors.grey, fontSize: 15,),),

                  SizedBox(
                    height: 11,

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(text:
                      TextSpan(
                          children:[
                            TextSpan(text:"\$${price.toString()}", style:TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold,fontSize: 15,),),
                            TextSpan(text: "/hr", style:TextStyle(color: Colors.blue[400], fontSize: 12,),),
                          ]
                      )),
                      Row(
                        children: [

                          Icon(Icons.swipe_down_alt_outlined, color: Colors.grey[800],),
                          Text(number.toString(), style:TextStyle(color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold),),

                        ],
                      )
                    ],
                  ),
                ],
              )),
          Positioned(
              top: 12,
              left: 12,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image(image: AssetImage("assets/icons/ic_save.png",),),
                  ))),


        ],
      ),
    );
  }

}