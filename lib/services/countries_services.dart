import 'dart:isolate';

import 'package:countries/models/country_data_model.dart';
import 'package:countries/services/api_helper.dart';
import 'package:countries/services/api_routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class CountriesServices {

  List<CountryDataModel>? countriesDataList = [];

  List<String>? countryRegions = [
    "Asia",
    "Americas",
    "Africa",
    "Europe",
    "Oceania",
    "Antarctic"
  ];

  List<String>? timezones = [
    "GMT+01:00",
    "GMT+02:00",
    "GMT+3:00",
    "GMT+4:00",
    "GMT+5:00",
    "GMT+6:00",
    "GMT+7:00",
    "GMT-06:00",
  ];

  Future getCountries() async {

    var response = await http.get(
        Uri.parse('${APIRoutes.baseCountryUrl}/countries'),
        headers: APIHelper().requestHeaders);

    final json = JSON.jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {

      await Isolate.run(() {

        List<CountryDataModel> resData = List<CountryDataModel>.from(
            json.map((x) => CountryDataModel.fromJson(x)));

        return resData;

      }, debugName: 'country parsing').then((value) {
        countriesDataList = value;
      });

      return countriesDataList;
    } else {
      var error = json["message"];
      throw Exception(error);
    }
  }
}