import 'package:flutter/material.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/main.dart';
import 'package:shopping/presentation/screens/advertisements/advertise.dart';
import 'package:shopping/presentation/screens/client/profile.dart';
import 'package:shopping/presentation/screens/home/home_body.dart';
import 'package:shopping/presentation/screens/menu.dart';

import 'package:shopping/presentation/widgets/person_container.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.name});
  String? name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedpref.getString("user_name");
    sharedpref.getString("img_path");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          selectedLabelStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          backgroundColor: brawn,
          selectedItemColor: Colors.white,
          unselectedItemColor: lightGrey,
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          unselectedIconTheme: IconThemeData(color: Colors.grey[500]),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _currentPage,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسيه',
              backgroundColor: Color.fromARGB(255, 55, 55, 55),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'اضف اعلانك',
              backgroundColor: Color.fromARGB(255, 55, 55, 55),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'الاعدادات',
              backgroundColor: Color.fromARGB(255, 55, 55, 55),
            ),
          ],
        ),
        drawer: Drawer(
            backgroundColor: Color(0xffd9d9d9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            width: 250,
            child: MenuScreen()),
        body: PageView(
          controller: _pageController,
          children: [
            //* body of home page
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: const PersonContainer()),
                  SizedBox(height: 10),
                  HomeBody(
                    user_name: widget.name,
                  ),
                ],
              ),
            ),
            //* body of advertisement
            AdvertiseScreen(),
            //*body of setting
            const ProfileScreen()
          ],
        ));
  }
}
