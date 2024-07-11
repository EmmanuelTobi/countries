import 'package:countries/models/country_data_model.dart';
import 'package:countries/services/countries_services.dart';
import 'package:countries/utils/locator_setup.dart';
import 'package:countries/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class CountriesHomeViewModel extends BaseViewModel {
  final countriesService = serviceLocator<CountriesServices>();

  List<String>? letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'Q', 'V', 'W', 'X', 'Y', 'Z'];

  List<String>? filteringLetters = [];

  List<CountryDataModel>? countriesData = [];
  List<CountryDataModel>? filteredCountriesData = [];
  CountryDataModel? currentPickedData;

  List<String> gmtFilters = [];
  List<String> regionFilters = [];

  List<String> selectedGmtFilters = [];
  List<String> selectedRegionFilters = [];

  int currentIndex = 0;
  final PageController pageController = PageController(
      keepPage: true,
      initialPage: 0
  );

  bool isSearching = false;

  void initialise() async {

    setBusy(true);

    filteringLetters = letters;
    gmtFilters = countriesService.timezones!;
    regionFilters = countriesService.countryRegions!;

    await countriesService.getCountries().then((value) {
      countriesData = countriesService.countriesDataList;
    });

    setBusy(false);

  }

  List<CountryDataModel>? getCountriesAlphabetically({String? letter}) {

    if(countriesData!.isEmpty) {
      countriesData = countriesService.countriesDataList;
    }

    print(isSearching);

    if(isSearching == false ) {
      countriesData = countriesService.countriesDataList!.where((element) => element.name![0].toUpperCase() == letter).toList();
    } else {
      countriesData = countriesData!.where((element) => element.name![0].toUpperCase() == letter).toList();
    }

    return countriesData;
  }

  void changeThemes() {  ///this can be set inside the countries service also so it can be called anywhere inside the app.
    if(ThemesSetup().isDark!) {
      countriesService.appThemeMode = AppThemeMode.LIGHT;
    } else {
      countriesService.appThemeMode = AppThemeMode.DARK;
    }
  }

  List<CountryDataModel>? getCountriesFiltered({String? s = ''}) {

    if(s!.length == 1 ) {

      countriesData!.clear();
      filteringLetters!.clear();

      filteringLetters = [ s[0].toUpperCase() ];
      letters = filteringLetters;
      isSearching = true;

      notifyListeners();

    }

     filteredCountriesData = countriesService.countriesDataList!.where((element) => element.name!.contains(s!)).toList();
     countriesData = filteredCountriesData;
     notifyListeners();

     return filteredCountriesData;
  }

  List<CountryDataModel>? getCountriesFilteredFromModal() {

    if(gmtFilters.isNotEmpty || regionFilters.isNotEmpty) {

      filteringLetters!.clear();
      filteredCountriesData!.clear();
      isSearching = true;

      if(gmtFilters.isNotEmpty) {
        for (var gmts in gmtFilters) {
          if(countriesService.countriesDataList!.where((element) => element.timezones!.contains(gmts)).toList().isNotEmpty) {
            filteredCountriesData!.add(countriesService.countriesDataList!.where((element) => element.timezones!.contains(gmts)).toList()[0]);
            filteringLetters!.add(countriesService.countriesDataList!.where((element) => element.timezones!.contains(gmts)).toList()[0].name![0].toUpperCase());
          }
        }
      }

      if(regionFilters.isNotEmpty) {
        for (var regions in regionFilters) {
          if(countriesService.countriesDataList!.where((element) => element.continents!.contains(regions)).toList().isNotEmpty) {
            filteredCountriesData!.add(countriesService.countriesDataList!.where((element) => element.continents!.contains(regions)).toList()[0]);
            filteringLetters!.add(countriesService.countriesDataList!.where((element) => element.continents!.contains(regions)).toList()[0].name![0].toUpperCase());
          }
        }
      }

      letters = filteringLetters;
      countriesData = filteredCountriesData;
      notifyListeners();

    } else {

      if(gmtFilters.isEmpty && regionFilters.isEmpty) {
        isSearching = false;
        filteredCountriesData = countriesData;
      }

    }

    return filteredCountriesData;

  }

  void resetFilteredFromModal() {
    initialise();
  }

  List<Widget>? pages({String? img1, String? img2, String? img3}) {

    return <Widget> [
      ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: SizedBox(
          // height: 40,
          // width: 50,
          child: SvgPicture.network(
            img1!,
            fit: BoxFit.fill,
          ),
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: SizedBox(
          // height: 40,
          // width: 50,
          child: SvgPicture.network(
            img2!,
            fit: BoxFit.contain,
          ),
        ),
      ),
      if(img3!.isNotEmpty) ... [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: SizedBox(
            height: 40,
            width: 50,
            child: SvgPicture.network(
              img3!,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ]

    ];

  }

  void onPageChanged(int index) {
    currentIndex = index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
  }

  void onPageChangeWithUserTap({String? action}) {

    print(pageController.page);

    if(action == 'back') {

      if(pageController.page != 0) {
        pageController.animateToPage(pageController.initialPage-1, duration: const Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
      }

    } else {

      pageController.animateToPage(pageController.initialPage+1, duration: const Duration(milliseconds: 300), curve: Curves.linearToEaseOut);

    }

  }

  void updateSelectedFilteringList({String? s, String? filterType}) {

    if(filterType == 'gmt') {

      if(!selectedGmtFilters.contains(s)) {
        selectedGmtFilters.add(s!);
      } else {
        selectedGmtFilters.remove(s!);
      }

    } else {

      if(!selectedRegionFilters.contains(s)) {
        selectedRegionFilters.add(s!);
      } else {
        selectedRegionFilters.remove(s!);
      }

    }

    notifyListeners();

  }

  void updateCurrentCountryModal ({ CountryDataModel? cmodel }) {
    currentPickedData = cmodel;
    notifyListeners();
  }



}