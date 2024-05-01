import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'my_app.dart';

Future<void> main() async {
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

// Create an application consisting of 2 screens with Flutter:
//
// List of tokens with a search bar. Tapping on the item opens the second screen.
// Details of the selected token:
// description
// price graph
// a calculator. The calculator has two inputs text fields: one in USD and the other in quantity. The user can change the value of a field and the application should update automatically the value of the other one.
// You can use Coingecko API to get the data.
//
// Libraries choice is up to you, we look for a clean and logical solution.
/// omar notes
/// next step order web service with clean arcitecture
/// mke sure wne you click on the token it takes you to new page
///
