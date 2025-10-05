
import 'package:first_app/APITestScreen.dart';
import 'package:first_app/Admin_module/AddAttendanceScreenAdmin.dart';
import 'package:first_app/Admin_module/AdminCustomWidgets/ManageAttendanceCategoryScreen.dart';
import 'package:first_app/Admin_module/AdminDashboard.dart';
import 'package:first_app/Admin_module/AdminLogInPage.dart';
import 'package:first_app/Admin_module/AttendanceManagementScreen.dart';
import 'package:first_app/Admin_module/DeleteAttendanceScreen.dart';
import 'package:first_app/Admin_module/EditAttendanceScreenAdmin.dart';
import 'package:first_app/Admin_module/LeaveManagementScreen.dart';
import 'package:first_app/Admin_module/SelectReportTypeScreen.dart';
import 'package:first_app/Admin_module/StudentsReportScreen.dart';
import 'package:first_app/Admin_module/SelectClassScreen.dart';
import 'package:first_app/Admin_module/StudentManagementScreen.dart';
import 'package:first_app/SearchScreen.dart';
import 'package:first_app/SelectLogInType.dart';
import 'package:first_app/SplashScreen.dart';
import 'package:first_app/UserModule/UserLogin.dart';
import 'package:go_router/go_router.dart';

import '../Admin_module/SystemReportScreen.dart';
class AppRouter {
  static final router= GoRouter(
      initialLocation: "/selectLoginType",
      routes: [

        GoRoute(path: "/apiTestScreen",
            builder: (context,state)=> APITestScreen()
        ),

        GoRoute(path: "/searchScreen", builder: (context, state) => SearchScreen()
        ),





        GoRoute(path: "/adminLogin",
            builder: (context, state)=> AdminLogInPage()
        ),
        GoRoute(path: "/adminDashboard",
            builder: (context, state)=> AdminDashboard()
        ),
        GoRoute(path: "/manageStudents",
            builder: (context, state)=> StudentManagementScreen()
        ),
        GoRoute(path: "/manageAttendance",
            builder: (context, state)=> AttendanceManagementScreen()
        ),
        GoRoute(path: "/selectClassScreen",
            builder: (context, state){

          return SelectClassScreen();}
        ),
        GoRoute(path: "/manageAttendanceCategory",
            builder: (context, state){
              final studentClass = state.extra as String;
         return ManageAttendanceCategoryScreen(studentClass:studentClass);}
        ),
        GoRoute(path: "/addAttendanceAdmin",
            builder: (context, state){
              final studentClass = state.extra as String;

          return AddAttendanceScreenAdmin(studentClass:studentClass);}
        ),
        GoRoute(path: "/editAttendanceAdmin",
            builder: (context, state)   {
          final studentClass = state.extra as String;
          return EditAttendanceScreenAdmin(studentClass:studentClass);
        }
        ),
            GoRoute(path: "/deleteAttendanceAdmin",
                builder: (context, state) {
              final studentClass = state.extra as String;
  return DeleteAttendanceScreen(studentClass:studentClass);}
            ),

        GoRoute(path: "/manageLeaves",
            builder: (context, state)=> LeaveManagementScreen()
        ),
        GoRoute(path: "/selectReportTypeScreen",
            builder: (context, state)=> SelectReportTypeScreen()
        ),
        GoRoute(path: "/StudentsReportScreen",
            builder: (context, state)=> StudentsReportScreen()
        ), GoRoute(path: "/SystemReportScreen",
            builder: (context, state)=> SystemReportScreen()
        ),




        // User Module Screens
        GoRoute(path: "/userLogin",
            builder: (context, state)=> UserLogIn()
        ),
        GoRoute(path: "/splashScreen",
            builder: (context, state)=> SplashScreen()
        ),

        GoRoute(path: "/selectLoginType",
            builder: (context, state)=> SelectLogInType()
        ),
      ]

  );
}