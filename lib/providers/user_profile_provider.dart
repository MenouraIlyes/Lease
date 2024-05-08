import 'package:flutter/material.dart';
import 'package:lease/Api_endpoint/services.dart';
import 'package:lease/models/user_profile_model.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile? _userProfile;

  // access the user profile
  UserProfile? get userProfile => _userProfile;

  //update the user profile
  void updateUserProfile(UserProfile newUserProfile) {
    _userProfile = newUserProfile;
    notifyListeners();
  }

  // fetch user infos by id
  Future<void> fetchUserProfileById(String id) async {
    try {
      _userProfile = await ApiService.fetchUserProfileById(id);
      notifyListeners();
    } catch (error) {
      print('Error fetching vehicles: $error');
    }
  }
}
