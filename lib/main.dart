
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/APITestScreen.dart';
import 'package:first_app/Admin_module/AdminDashboard.dart';
import 'package:first_app/Admin_module/AdminLogInPage.dart';
import 'package:first_app/Admin_module/AdminProviders/LeaveManagmentProvider.dart';
import 'package:first_app/Admin_module/AdminProviders/StudentReportProvider.dart';
import 'package:first_app/Admin_module/AdminProviders/SysytemReportProvider.dart';
import 'package:first_app/Providers/AttendanceCountProvider.dart';
import 'package:first_app/Providers/AttendenceListProvider.dart';
// import 'package:first_app/AdminProviders/EditStudentsAttendanceProvider.dart';
import 'package:first_app/Providers/CounterProvider.dart';
import 'package:first_app/Providers/LeaveRequestDatesProvider.dart';
import 'package:first_app/Providers/MapListProvider.dart';
import 'package:first_app/Providers/ProfileImageProvider.dart';
import 'package:first_app/Providers/SignUpPageProvider.dart';
import 'package:first_app/Providers/ThemeProvider.dart';
import 'package:first_app/Router/AppRouter.dart';
import 'package:first_app/SelectLogInType.dart';
import 'package:first_app/SignUpPage.dart';
import 'package:first_app/SplashScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Admin_module/AdminProviders/AddStudentsAttendanceProvider.dart';
import 'Admin_module/AdminProviders/DeleteStudentsAttendanceProvider.dart';
import 'Admin_module/AdminProviders/EditStudentsAttendanceProvider.dart';
import 'Providers/WeatherProvider.dart';
import 'firebase_options.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AttendenceListProvider()),
          ChangeNotifierProvider(create: (_) => LeaveRequestDatesProvider()),
          ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
          ChangeNotifierProvider(create: (_) => AttendanceCountProvider()),
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          ChangeNotifierProvider(create: (_) => EditStudentsAttendanceProvider()),
          ChangeNotifierProvider(create: (_) => DeleteStudentsAttendanceProvider()),
          ChangeNotifierProvider(create: (_) => MapListProvider()),
          ChangeNotifierProvider(create: (_) => StudentReportProvider()),
          ChangeNotifierProvider(create: (_) => SysytemReportProvider()),
          ChangeNotifierProvider(create: (_) => LeaveManagmentProvider()),
          ChangeNotifierProvider(create: (_) => AddStudentsAttendanceProvider()),
          ChangeNotifierProvider(create: (_) => WeatherProvider()),
          ChangeNotifierProvider(create: (_) => SignUpPageProvider()),
        ],
     child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
routerConfig: AppRouter.router,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        fontFamily: 'manrope',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),


    )
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(



        backgroundColor: Colors.white,

        title: Text(widget.title),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          SizedBox(height: 20,),




        ],
      ));
  }
}
