import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/models/vehicle_model.dart';
import 'package:lease/providers/user_profile_provider.dart';
import 'package:lease/providers/vehicle_provider.dart';
import 'package:lease/screens/vehicle_detail_screen.dart';
import 'package:lease/shared/colors.dart';
import 'package:provider/provider.dart';

// Custom loading indicator widget
class CustomLoadingIndicator extends StatelessWidget {
  final String message;

  CustomLoadingIndicator({this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16.0),
            Text(
              message,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LikesCars extends StatefulWidget {
  const LikesCars({super.key});

  @override
  State<LikesCars> createState() => _LikesCars();
}

class _LikesCars extends State<LikesCars> {
  @override
  void initState() {
    super.initState();
    Provider.of<VehicleProvider>(context, listen: false).fetchVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Your Favourites",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: appWhite,
            boxShadow: [
              BoxShadow(
                color: appBlack.withOpacity(0.1),
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: const Offset(0.0, 1.0),
              )
            ],
          ),
        ),
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, _) {
          final CustomerUsername = userProfileProvider.userProfile!.username;

          return Consumer<VehicleProvider>(
            builder: (context, vehicleProvider, _) {
              // Access the list of vehicles
              List<Vehicle> LikedVehicles = vehicleProvider.favourites;

              if (LikedVehicles.isEmpty) {
                return Center(
                  child: CustomLoadingIndicator(message: 'No Liked Vehicles'),
                );
              }

              return Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: ListView.builder(
                  itemCount: LikedVehicles.length,
                  itemBuilder: (context, index) {
                    final car = LikedVehicles[index];
                    return PropertyCard(property: car);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PropertyCard extends StatefulWidget {
  final Vehicle property;

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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VehicleDetailsScreen(selectedVehicle: widget.property),
              ),
            );
          },
          child: Stack(
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
                  children: widget.property.photos.map((imagePath) {
                    return Image.file(File(imagePath), fit: BoxFit.cover);
                  }).toList(),
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 0.0,
                right: 0.0,
                child: DotsIndicator(
                  dotsCount: widget.property.photos.length,
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
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.property.make}, ${widget.property.model}',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: appBlue,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.property.basePrice} DA',
                  ),
                ],
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
