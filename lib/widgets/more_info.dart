import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/screens/edit_profile_screen.dart';
import 'package:lease/shared/colors.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.moon),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage('assets/road.jpg'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: appBlue,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.pencil,
                        color: appGrey,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Menoura Ilyes',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'ilyesmenoura19@gmail.com',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.poppins(color: appWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBlue.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              //Menu
              ProfileMenuWidget(
                title: "Settings",
                icon: FontAwesomeIcons.gear,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Billing Details",
                icon: FontAwesomeIcons.wallet,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "User Management",
                icon: FontAwesomeIcons.check,
                onPress: () {},
              ),
              const Divider(color: appGrey),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Information",
                icon: FontAwesomeIcons.info,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Logout",
                textColor: appRed,
                endIcon: false,
                icon: FontAwesomeIcons.arrowRightFromBracket,
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: appBlue.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: appBlue,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins().apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: appGrey.withOpacity(0.1),
              ),
              child: const Icon(
                FontAwesomeIcons.arrowRight,
                color: appGrey,
              ),
            )
          : null,
    );
  }
}
