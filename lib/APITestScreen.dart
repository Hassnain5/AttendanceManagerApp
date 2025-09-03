
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APITestScreen extends StatelessWidget{


  List<UserModel> userPostsData=[];

  Future<List<UserModel>> getUser() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var responseData = jsonDecode(response.body);
    if(response.statusCode== 200){
      for(Map a in responseData){
      userPostsData.add(UserModel.fromJson(Map <String,dynamic>.from(a)));
      }
      return userPostsData;
    }else
      return [];

  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body:Padding(
       padding: const EdgeInsets.all(8.0),
       child: FutureBuilder(future: getUser(), builder: (context, snapshot){

         final data=snapshot.data!;
         if(snapshot.hasData){
           return ListView.builder(
               itemCount: snapshot.data!.length,
               itemBuilder: (context,index){

             return Card(
               child: ListTile(
                 title: Text("${data[index].title}", ),
                 subtitle: Text("${data[index].body}", ),
               ),
             );
           });
         }else{
           return Center(child: Text("No Data Found",style: TextStyle(fontSize: 20),));
         }
       }),
     ) ,
   );
  }
}

