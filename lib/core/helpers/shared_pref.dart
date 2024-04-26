import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_riverpod/core/constants/app_config.dart';
import 'package:todo_riverpod/features/auth/domain/user_model.dart';

class SharedPref {
  // For plain-text data
  Future<void> set(String key, dynamic value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    }
  }

  Future<bool> get(String key, {dynamic defaultValue}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.get(key) ?? defaultValue;
  }

  Future<void> setCurrentUser(UserModel model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(AppConfig.user, jsonEncode(model.toJson()));
  }

  Future<UserModel?> get currentSavedUser async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(AppConfig.user);
    if (data != null) {
      return UserModel.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }
}
