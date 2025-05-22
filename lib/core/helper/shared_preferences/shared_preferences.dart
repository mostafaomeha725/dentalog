import 'dart:convert';

import 'package:dentalog/core/api/end_ponits.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {


  Future<void> saveId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        ApiKey.id, id); // Save the token with the key 'user_token'
  }

  // Get token from SharedPreferences
  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
         ApiKey.id); // Retrieve the token using the 'user_token' key
  }

  // Remove token from SharedPreferences
  Future<void> removeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .remove(ApiKey.id); // Remove the token with the key 'user_token'
  }

  Future<void> clearProfileCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_profile');
  }

  Future<void> saveProfileData(Map<String, dynamic> profileData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonProfile =
        jsonEncode(profileData); // Convert profile data to JSON string
    await prefs.setString('user_profile',
        jsonProfile); // Save profile data with the key 'user_profile'
  }

  // Get profile data from SharedPreferences
  Future<Map<String, dynamic>?> getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonProfile =
        prefs.getString('user_profile'); // Retrieve profile data as JSON string
    if (jsonProfile != null) {
      return jsonDecode(jsonProfile); // Convert JSON string back to Map
    }
    return null; // Return null if profile data is not found
  }


  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // مسح جميع البيانات
  }


 Future<void> saveUser(String key,String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getUser(String value) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(value);
}
}
