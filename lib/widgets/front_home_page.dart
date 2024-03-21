import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/shared/colors.dart';

class FrontHomeScreen extends StatelessWidget {
  const FrontHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lease, rent a car with ease !!',
                    style: GoogleFonts.poppins(
                        color: appBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome to Lease, the ultimate solution for all your car rental needs. Whether you're planning a weekend getaway, a business trip, or simply need a reliable ride for daily commuting, we got you covered.",
                    style: GoogleFonts.poppins(
                        color: appBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              // Your picture widget here
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/welcome.jpg'), fit: BoxFit.cover),
              ),
              height: 600,
              child: Container(
                color: Colors.black
                    .withOpacity(0.2), // Adjust opacity for darkness level
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Why Choose Lease?',
                  style: GoogleFonts.poppins(
                      color: appBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/reliable.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Reliability :',
                        style: GoogleFonts.poppins(
                            color: appBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'With Lease, you can always count on reliable vehicles and top-notch service.',
                    style: GoogleFonts.poppins(
                        color: appBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Image.asset(
                      'assets/convenience.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Convenience :',
                      style: GoogleFonts.poppins(
                          color: appBlack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Our app puts the entire car rental process at your fingertips, saving you time and effort.',
                    style: GoogleFonts.poppins(
                        color: appBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/afford.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Affordability :',
                        style: GoogleFonts.poppins(
                            color: appBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Enjoy competitive rates and transparent pricing, ensuring that you get the best value for your money.',
                    style: GoogleFonts.poppins(
                        color: appBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/satisfied.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Satisfaction :',
                        style: GoogleFonts.poppins(
                            color: appBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'We prioritize customer satisfaction above all else, striving to exceed your expectations with every rental.',
                    style: GoogleFonts.poppins(
                        color: appBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              // Your picture widget here
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/footer.jpg'), fit: BoxFit.cover),
              ),
              height: 500,
              child: Container(
                color: Colors.black
                    .withOpacity(0.2), // Adjust opacity for darkness level
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Join Us Today !',
                    style: GoogleFonts.poppins(
                        color: appBlue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Become a Lease member for exclusive perks, offers, and updates. Let's drive together.",
                style: GoogleFonts.poppins(
                    color: appBlack, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
