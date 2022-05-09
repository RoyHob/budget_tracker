import 'package:budget_tracker/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  return runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ),);
}