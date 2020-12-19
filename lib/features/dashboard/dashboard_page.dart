import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';

import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/features/home/home_page.dart';
import 'package:amadis_delivery/features/list_orders/list_orders.dart';
import 'package:amadis_delivery/features/profile/profile_page.dart';
import 'package:amadis_delivery/features/take_order/take_order_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardPage> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        // ignore: missing_return
        onNotification: (scrollNotification) {
          checkUserDragging(scrollNotification);
        },
        child: PageView(
          controller: _pageController,
          physics: BouncingScrollPhysics(),
          children: [
            HomePage(),
            ListOrdersPage(),
            TakeOrderPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BubbledNavigationBar(
        backgroundColor: Colors.white,
        controller: _menuPositionController,
        defaultBubbleColor: AmadisColors.secondaryColor,
        initialIndex: 0,
        itemMargin: const EdgeInsets.symmetric(horizontal: 8.0),
        onTap: (index) {
          _pageController.animateToPage(index,
              curve: Curves.easeInOutQuad,
              duration: Duration(milliseconds: 500));
        },
        items: [
          BubbledNavigationBarItem(
            icon: Icon(Icons.home, size: 30, color: AmadisColors.primaryColor),
            activeIcon: Icon(Icons.home, size: 30, color: Colors.white),
            title: Text('Home',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          BubbledNavigationBarItem(
            icon: Icon(Icons.location_on,
                size: 30, color: AmadisColors.primaryColor),
            activeIcon: Icon(Icons.location_on, size: 30, color: Colors.white),
            title: Text('Pedidos',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          BubbledNavigationBarItem(
            icon: Icon(Icons.add_circle_outline,
                size: 30, color: AmadisColors.primaryColor),
            activeIcon:
                Icon(Icons.add_circle_outline, size: 30, color: Colors.white),
            title: Text('Nuevo Pedido',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          BubbledNavigationBarItem(
            icon: Icon(Icons.person_outline,
                size: 30, color: AmadisColors.primaryColor),
            activeIcon:
                Icon(Icons.person_outline, size: 30, color: Colors.white),
            title: Text('Perfil',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
