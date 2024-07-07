import 'package:countries/models/country_data_model.dart';
import 'package:countries/services/countries_services.dart';
import 'package:countries/utils/locator_setup.dart';
import 'package:flutter/material.dart';
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

    if(isSearching == false ) {
      countriesData = countriesData!.where((element) => element.name![0].toUpperCase() == letter).toList();
    }

    return countriesData;
  }

  List<CountryDataModel>? getCountriesFiltered({String? s = ''}) {

    if(s!.length == 1 ) {

      countriesData!.clear();
      filteringLetters!.clear();

      filteringLetters = [ s[0].toUpperCase() ];
      letters = filteringLetters;
      notifyListeners();

    }

     filteredCountriesData = countriesService.countriesDataList!.where((element) => element.name!.contains(s!)).toList();
     countriesData = filteredCountriesData;
     notifyListeners();

     return filteredCountriesData;
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