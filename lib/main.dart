import 'package:countries/services/countries_services.dart';
import 'package:countries/utils/locator_setup.dart';
import 'package:countries/utils/themes.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemesSetup.getThemeDataFromThemeMode(
          context,
          serviceLocator<CountriesServices>().appThemeMode!
      ),
      home: const CountriesHome(),
    );
  }

}