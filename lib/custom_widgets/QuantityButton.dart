

import 'package:first_app/Providers/CounterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityButton extends StatelessWidget{

const QuantityButton({super.key});
  @override
  Widget build(BuildContext context) {
    // print("Quantity button build called !");
    // final counterProvIns = Provider(create: create)
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(

          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(10),

          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Container(
                  color: Colors.indigo[700],
                  child: IconButton(onPressed: (){ context.read<CounterProvider>().decrementCount();},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),

                    icon: const Icon(Icons.remove),color: Colors.white,),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:Consumer<CounterProvider>(builder: (ctx,value,child){

                      // print("quantity button Build ctx called!!!");

                      return Text('${ctx.watch<CounterProvider>().getCount()}' , style: const TextStyle(color: Colors.black));

                    })    ),
                ),
                Container(
                  color: Colors.indigo[700],

                  child: IconButton(onPressed:(){ context.read<CounterProvider>().incrementCount();},
                      padding: EdgeInsets.zero,

                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.add,color: Colors.white,)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}