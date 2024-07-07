class CountryDataModel {
  String? name;
  List<String>? tld;
  String? cca2;
  String? ccn3;
  String? cca3;
  String? cioc;
  String? fifa;
  bool? independent;
  String? status;
  bool? unMember;
  dynamic currencies;
  String? callingcode;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  List<String>? continents;
  Languages? languages;
  List<dynamic>? latlng;
  bool? landlocked;
  List<String>? borders;
  dynamic area;
  String? flag;
  String? coatOfArms;
  dynamic population;
  Maps? maps;
  Car? car;
  String? postalCodeFormat;
  String? startOfWeek;
  List<String>? timezones;

  CountryDataModel(
      {this.name,
        this.tld,
        this.cca2,
        this.ccn3,
        this.cca3,
        this.cioc,
        this.fifa,
        this.independent,
        this.status,
        this.unMember,
        this.currencies,
        this.callingcode,
        this.capital,
        this.altSpellings,
        this.region,
        this.subregion,
        this.continents,
        this.languages,
        this.latlng,
        this.landlocked,
        this.borders,
        this.area,
        this.flag,
        this.coatOfArms,
        this.population,
        this.maps,
        this.car,
        this.postalCodeFormat,
        this.startOfWeek,
        this.timezones});

  CountryDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tld = json['tld'].cast<String>();
    cca2 = json['cca2'];
    ccn3 = json['ccn3'];
    cca3 = json['cca3'];
    cioc = json['cioc'];
    fifa = json['fifa'];
    independent = json['independent'];
    status = json['status'];
    unMember = json['unMember'];
    currencies = json['currencies'];
    callingcode = json['callingcode'];
    capital = json['capital'].cast<String>();
    altSpellings = json['altSpellings'].cast<String>();
    region = json['region'];
    subregion = json['subregion'];
    continents = json['continents'].cast<String>();
    languages = json['languages'] != null
        ? Languages.fromJson(json['languages'])
        : null;
    latlng = json['latlng'].cast<int>();
    landlocked = json['landlocked'];
    borders = json['borders'].cast<String>();
    area = json['area'];
    flag = json['flag'];
    coatOfArms = json['coatOfArms'];
    population = json['population'];
    maps = json['maps'] != null ? Maps.fromJson(json['maps']) : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    postalCodeFormat = json['postalCodeFormat'];
    startOfWeek = json['startOfWeek'];
    timezones = json['timezones'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tld'] = tld;
    data['cca2'] = cca2;
    data['ccn3'] = ccn3;
    data['cca3'] = cca3;
    data['cioc'] = cioc;
    data['fifa'] = fifa;
    data['independent'] = independent;
    data['status'] = status;
    data['unMember'] = unMember;
    if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    data['callingcode'] = callingcode;
    data['capital'] = capital;
    data['altSpellings'] = altSpellings;
    data['region'] = region;
    data['subregion'] = subregion;
    data['continents'] = continents;
    if (languages != null) {
      data['languages'] = languages!.toJson();
    }
    data['latlng'] = latlng;
    data['landlocked'] = landlocked;
    data['borders'] = borders;
    data['area'] = area;
    data['flag'] = flag;
    data['coatOfArms'] = coatOfArms;
    data['population'] = population;
    if (maps != null) {
      data['maps'] = maps!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['postalCodeFormat'] = postalCodeFormat;
    data['startOfWeek'] = startOfWeek;
    data['timezones'] = timezones;
    return data;
  }
}

class Currencies {
  CNY? cNY;

  Currencies({this.cNY});

  Currencies.fromJson(Map<String, dynamic> json) {
    cNY = json['CNY'] != null ? CNY.fromJson(json['CNY']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cNY != null) {
      data['CNY'] = cNY!.toJson();
    }
    return data;
  }
}

class CNY {
  String? name;
  String? symbol;

  CNY({this.name, this.symbol});

  CNY.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['symbol'] = symbol;
    return data;
  }
}

class Languages {
  String? lang;

  Languages({this.lang});

  Languages.fromJson(Map<String, dynamic> json) {
    lang = json[json.keys.toList().isNotEmpty ? json.keys.toList()[0] : 'eng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zho'] = lang;
    return data;
  }
}

class Maps {
  String? googleMaps;
  String? openStreetMaps;

  Maps({this.googleMaps, this.openStreetMaps});

  Maps.fromJson(Map<String, dynamic> json) {
    googleMaps = json['googleMaps'];
    openStreetMaps = json['openStreetMaps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['googleMaps'] = googleMaps;
    data['openStreetMaps'] = openStreetMaps;
    return data;
  }
}

class Car {
  List<String>? signs;
  String? side;

  Car({this.signs, this.side});

  Car.fromJson(Map<String, dynamic> json) {
    signs = json['signs'].cast<String>();
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['signs'] = signs;
    data['side'] = side;
    return data;
  }
}