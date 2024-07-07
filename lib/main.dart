import 'package:countries/utils/locator_setup.dart';
import 'package:countries/views/countries_home/countries_home_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await locatorSetup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.white),
        useMaterial3: true,
      ),
      home: const CountriesHome(),
    );
  }

}