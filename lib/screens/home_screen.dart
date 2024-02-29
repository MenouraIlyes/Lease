import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lease/models/car.dart';
import 'package:lease/screens/welcome_screen.dart';
import 'package:lease/shared/colors.dart';
import 'package:lease/widgets/app_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: const AppNavBar(),
      appBar: AppBar(
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
                                style: textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
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
      ),
      // body: Padding(
      //   padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      //   child: ListView.builder(
      //     itemCount: Car.sampleData.length,
      //     itemBuilder: (context, index) {
      //       final property = Car.sampleData[index];
      //       return PropertyCard(property: property);
      //     },
      //   ),
      // ),
      body: const WelcomeScreen(),
    );
  }
}

class PropertyCard extends StatefulWidget {
  final Car property;

  const PropertyCard({Key? key, required this.property}) : super(key: key);

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  final controller = PageController();
  var currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: size.width,
              height: size.width - 32.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                children: widget.property.photoUrls.map((imageUrl) {
                  return Image.network(imageUrl, fit: BoxFit.cover);
                }).toList(),
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: 0.0,
              right: 0.0,
              child: DotsIndicator(
                dotsCount: widget.property.photoUrls.length,
                position: currentPage,
                onTap: (index) {
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                decorator: DotsDecorator(
                  color: colorScheme.onSecondary,
                  activeColor: colorScheme.secondary,
                  size: const Size.square(8.0),
                  activeSize: const Size(12.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.property.name}, ${widget.property.city}',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.property.size,
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.property.transmission,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
