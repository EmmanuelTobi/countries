import 'package:countries/models/country_data_model.dart';
import 'package:countries/services/countries_services.dart';
import 'package:countries/utils/locator_setup.dart';
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

  bool isSearching = false;

  void initialise() async {

    setBusy(true);

    filteringLetters = letters;

    await countriesService.getCountries().then((value) {
      countriesData = countriesService.countriesDataList;
    });

    setBusy(false);

  }

  List<CountryDataModel>? getCountriesAlphabetically({String? letter}) {

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

  void updateCurrentCountryModal ({ CountryDataModel? cmodel }) {
    currentPickedData = cmodel;
    notifyListeners();
  }



}