import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/modules/home/home_screen.dart';
import 'package:photo_editor_pro/app/modules/profile/profile_screen.dart';
import 'package:photo_editor_pro/app/modules/templates/template.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({ Key? key }) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int selectedIndex = 0;
  final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [
          HomeScreen(),
          TemplateScreen(),
          ProfileScreen()
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: sizeText(context, 15),
        selectedFontSize: sizeText(context, 10),
        unselectedFontSize: sizeText(context, 10),
        selectedItemColor: secondColor,
        unselectedItemColor: lightGrey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600
        ),   
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600
        ),          
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: sizePersen(context, 1.5)),
              child: const Icon(Ionicons.pulse_outline),
            ),
            label: "Chỉnh sửa"
          ),
            BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: sizePersen(context, 1.5)),
              child: const Icon(Ionicons.flash_outline),
            ),
            label: "Template"
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: sizePersen(context, 1.5)),
              child: const Icon(Ionicons.person_outline),
            ),
            label: "MY"
          )
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            _pageController.jumpToPage(selectedIndex);
          });
        }
      ),
    );
  }
}