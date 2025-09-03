import 'package:first_app/Admin_module/AdminLogInPage.dart';
import 'package:first_app/HelperClasses/SessionManager.dart';
import 'package:first_app/UserModule/BottomNavContainer.dart';
import 'package:first_app/UserModule/UserDashboard.dart';
import 'package:first_app/UserModule/UserLogin.dart';
import 'package:flutter/material.dart';

class SelectLogInType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _checkSession()async {
      bool isLoggedIn= await SessionManager.hasSession();
      String? userId = await SessionManager.getUserId();
      if(isLoggedIn){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavContainer(userId: userId,)));

      }
      else
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserLogIn()));

    }
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),

                child: InkWell(

                  onTap: ()async{

                    _checkSession();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(20),


                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        children: [
                          Image.asset("assets/images/studentlogin.png", width: 70, height: 70),
                          SizedBox(height: 20),
                          Text(
                            "Login as Student",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),

                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminLogInPage()));

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        children: [
                          Image.asset("assets/images/adminicon.png", width: 70, height: 70),
                          SizedBox(height: 20),
                          Text(
                            "Login as Admin",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
