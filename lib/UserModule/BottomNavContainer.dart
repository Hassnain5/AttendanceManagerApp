import 'package:first_app/HelperClasses/SessionManager.dart';
import 'package:first_app/UserModule/UserDashboard.dart';
import 'package:flutter/material.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:iconsax/iconsax.dart';

import 'UserProfileScreen.dart';


class BottomNavContainer extends StatefulWidget {
  final String? userId;

  const BottomNavContainer({super.key, required this.userId});

  @override
  State<BottomNavContainer> createState() => _BottomNavContainerState();
}

class _BottomNavContainerState extends State<BottomNavContainer> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
@override
  void initState() {
  super.initState();


   _pages = [
    UserDashBoard(uid:widget.userId ),
    UserProfileScreen(userId: widget.userId),
    // SearchPage(),
  ];
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        color: Colors.grey[400],
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,

        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(

          decoration: BoxDecoration(


            borderRadius: BorderRadius.circular(30)

          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),

            child: Material(
              shadowColor: Colors.grey,
              child: ConvexAppBar(
                height: 75,
                initialActiveIndex: _selectedIndex,
                activeColor: Colors.blue[500],

                backgroundColor: Colors.white,
                color: Colors.grey,
                style: TabStyle.react,

                onTap: (index) => setState(() => _selectedIndex = index),
                items: [
                  TabItem(
                    icon: Icon(
                      Iconsax.element_4,
                      color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                    title: "Dashboard",
                  ),
                  TabItem(
                    icon: Icon(
                      Iconsax.user,
                      color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                    title: "Profile",
                  ), // TabItem(icon: Icons.search, title: 'Search'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
