
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PersonDetailTexts extends StatelessWidget{
  final double price;
  final String location;
  final double rating;
  const PersonDetailTexts({super.key , required this.price, required this.location, required this.rating});
  @override
  Widget build(BuildContext context) {
    return
       Column(
         mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children:[
             RichText(text:
             TextSpan(
               children: [
                 TextSpan(text:"\$${price.toString()}", style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 24,),),
                 TextSpan(text: "/week", style:TextStyle(color: Colors.grey, fontSize: 18,),),
               ]
             )
             ),
             Row(
               children: [

                 Icon(Iconsax.location, color: Colors.grey[500],size: 14,),
                 Text(location, style:TextStyle(color: Colors.grey[500], fontSize: 14, fontWeight: FontWeight.bold),),

               ],
             ),
             Card(

               color: Colors.white,

               child: Padding(
                 padding: const EdgeInsets.all(6.0),
                 child: Row(
                   children: [

                     Icon(Icons.star, color: Colors.yellow[700],),
                     SizedBox(width: 4,),
                     Text(rating.toString(), style:TextStyle(color: Colors.black, fontSize: 15,),)
                   ],
                 ),
               ),
             ),

           ],
       );
  }

}
