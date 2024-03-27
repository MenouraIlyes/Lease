import 'package:flutter/material.dart';
import 'package:lease/models/user_profile_model.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile? _userProfile;

  // access the user profile
  UserProfile? get userProfile => _userProfile;

  // Function to update the user profile
  void updateUserProfile(UserProfile newUserProfile) {
    _userProfile = newUserProfile;
    notifyListeners();
  }
}
