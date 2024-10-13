
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../pages/tabs/tab_home.dart' as maintab;
import '../pages/tabs/tab_history.dart' as historytab;
import '../pages/tabs/tab_setting.dart' as settingtab;
import '../pages/tabs/tab_other.dart' as othertab;

import '../helpers/constant.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  
  int _selectedIndex = 0;

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  // late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final List<Widget> _children = [
    const maintab.TabHome(),
    const historytab.TabHistory(),
    const othertab.TabOther(),
    const settingtab.TabSetting()
  ];

  late TabController controller;
  late String cacheNama;

  final iconList = <IconData>[
    Icons.home,
    Icons.history,
    Icons.card_travel_outlined,
    Icons.settings,
  ];

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);

    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    // borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
    //   borderRadiusCurve,
    // );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Warna.putih,
        body: _children[_selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Warna.kuning,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),
          onPressed: () {
            
          },
          child: Icon(
            Icons.qr_code_2_rounded,
            color: Warna.putih,
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: Warna.putih,
                ),
                // const SizedBox(height: 4),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: AutoSizeText(
                //     "Home $index",
                //     maxLines: 1,
                //     style: TextStyle(color: color),
                //     group: autoSizeGroup,
                //   ),
                // )
              ],
            );
          },
          backgroundColor: Warna.kuning,
          activeIndex: _selectedIndex,
          splashColor: Colors.black87,
          // notchAndCornersAnimation: borderRadiusAnimation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) => setState(() => _selectedIndex = index),
          hideAnimationController: _hideBottomBarAnimationController,
          shadow: const BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: Colors.transparent,
          ),
        ),
      )
    );
  }
}
