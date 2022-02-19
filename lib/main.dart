import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freshflow_test/app/app_runner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApplication();
}