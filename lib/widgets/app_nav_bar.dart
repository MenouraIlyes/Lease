import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lease/shared/colors.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: appBlack.withOpacity(0.1),
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, -1.0),
          )
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(
            Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: appBlue,
                ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (int index) {},
          indicatorColor: Colors.transparent,
          selectedIndex: 0,
          height: 56,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              label: 'Explore',
              selectedIcon: Icon(
                Icons.search,
                color: appBlue,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Wishlist',
              selectedIcon: Icon(
                Icons.favorite,
                color: appBlue,
              ),
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.road),
              label: 'Trips',
              selectedIcon: Icon(
                FontAwesomeIcons.road,
                color: appBlue,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Log in',
              selectedIcon: Icon(
                Icons.person,
                color: appBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
