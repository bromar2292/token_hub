import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'my_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

/// omar

/// loggins
/// omar makke repository interface in the domain layer
/// presnetation shouldnt know about data layer
/// use env

/// make sure can download and run from other laptop
/// make sure it works on iphone
