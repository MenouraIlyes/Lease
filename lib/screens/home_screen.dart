import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lease/widgets/car_trips.dart';
import 'package:lease/widgets/front_home_page.dart';
import 'package:lease/widgets/liked_cars.dart';
import 'package:lease/widgets/more_info.dart';
import 'package:lease/shared/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    FrontHomeScreen(),
    LikesCars(),
    CarTrips(),
    MoreWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: appWhite,
        color: appBlack,
        activeColor: appBlue,
        onTabChange: (index) {
          _navigateBottomBar(index);
        },
        tabs: [
          GButton(
            icon: Icons.search_outlined,
            text: 'Search',
          ),
          GButton(
            icon: Icons.favorite_border_outlined,
            text: 'Likes',
          ),
          GButton(
            icon: FontAwesomeIcons.road,
            text: 'Trips',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
      appBar: _selectedIndex == 0
          ? AppBar(
              toolbarHeight: 80,
              flexibleSpace: Container(
                decoration: BoxDecoration(color: appWhite, boxShadow: [
                  BoxShadow(
                    color: appBlack.withOpacity(0.1),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0.0, 1.0),
                  )
                ]),
                child: Stack(
                  children: [
                    Positioned(
                      right: 50.0,
                      top: 35.0,
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed('booking-details');
                        },
                        child: Hero(
                          tag: 'search',
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 36.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: appWhite,
                              border: Border.all(
                                color: appGrey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color: appGrey.withOpacity(0.5),
                                  blurRadius: 8.0,
                                  spreadRadius: 8.0,
                                  offset: const Offset(0.0, 4.0),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Where to?',
                                      style: textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'City, airport, addresse or hotel',
                                      style: textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : null,
      body: pages[_selectedIndex],
    );
  }
}
