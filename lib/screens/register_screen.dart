import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/Api_endpoint/services.dart';
import 'package:lease/models/user_profile_model.dart';
import 'package:lease/providers/user_profile_provider.dart';
import 'package:lease/shared/colors.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _email;
  late final TextEditingController _phoneNumber;
  String role = "customer";

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    String username = _username.text;
    String password = _password.text;
    String email = _email.text;
    String phoneNumber = _phoneNumber.text;

    // Check if any required field is empty
    if (username.isEmpty ||
        password.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check username length
    if (username.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username must be at least 8 characters long.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check if email is valid
    final emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    if (!emailRegExp.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check password length
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least 8 characters long.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check if phone number is valid
    final phoneRegExp = RegExp(
      r'^(05|06|07)\d{8}$',
      caseSensitive: false,
      multiLine: false,
    );
    if (!phoneRegExp.hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid phone number.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check if a role is selected
    if (role.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a role.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Create a UserProfile object with the new information
      var newUserProfile = UserProfile(
        username: username,
        password: password,
        email: email,
        phoneNumber: phoneNumber,
        role: role,
      );

      // Call the registerUser function with the UserProfile object
      await ApiService.registerUser(newUserProfile);

      var userProfileProvider =
          Provider.of<UserProfileProvider>(context, listen: false);
      userProfileProvider.updateUserProfile(newUserProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Registration successful!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
      context.go('/home-registered');
    } catch (error) {
      print('Error registering user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login.jpg'),
                    ),
                  ),
                ),
                //text
                Text(
                  "welcome to lease",
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Fill your informations below !",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),

                //username textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _username,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                //password textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),

                //phone-number textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _phoneNumber,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Role:',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              activeColor: appBlue,
                              value: 'customer',
                              groupValue: role,
                              onChanged: (value) {
                                setState(() {
                                  role = value!;
                                });
                              },
                              title: Text('Customer',
                                  style: GoogleFonts.poppins(color: appBlack)),
                              tileColor: appWhite,
                              dense: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: RadioListTile<String>(
                              activeColor: appBlue,
                              value: 'agency',
                              groupValue: role,
                              onChanged: (value) {
                                setState(() {
                                  role = value!;
                                });
                              },
                              title: Text('Agency',
                                  style: GoogleFonts.poppins(color: appBlack)),
                              tileColor: appWhite,
                              dense: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //sign it button
                Container(
                  child: MaterialButton(
                    minWidth: 330,
                    height: 50,
                    onPressed: () {
                      _registerUser();
                    },
                    color: appBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: appWhite),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Join us",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: appWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
