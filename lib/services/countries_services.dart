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
    "UTC+08:00",
    "UTC+05:30",
    "UTC-12:00",
    "UTC-11:00",
    "UTC-10:00",
    "UTC-09:00",
    "UTC-08:00",
    "UTC-07:00",
    "UTC-06:00",
    "UTC-05:00",
    "UTC-04:00",
    "UTC+10:00",
    "UTC+12:00",
    "UTC+07:00",
    "UTC+09:00",
    "UTC+05:00",
    "UTC-03:00",
    "UTC-02:00",
    "UTC+01:00",
    "UTC+06:00",
    "UTC+03:00",
    "UTC+04:00",
    "UTC+11:00",
    "UTC+02:00",
    "UTC+03:30",
    "UTC-09:30",
    "UTC",
    "UTC+06:30",
    "UTC+04:30",
    "UTC-03:30",
    "UTC+05:45",
    "UTC+09:30",
    "UTC+10:30",
    "UTC+11:30",
    "UTC-01:00",
    "UTC+12:45",
    "UTC+13:00",
    "UTC+00:00",
    "UTC+14:00"
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