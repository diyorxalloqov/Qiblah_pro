class AutoChoiceLocationModel{
  final City city;
  final Continent continent;
  final Country country;
  final Location location;
  final List<Subdivision> subdivisions;
  final StateData state;
  final List<Datasource> datasource;
  final String ip;

  AutoChoiceLocationModel({
    required this.city,
    required this.continent,
    required this.country,
    required this.location,
    required this.subdivisions,
    required this.state,
    required this.datasource,
    required this.ip,
  });

  factory AutoChoiceLocationModel.fromJson(Map<String, dynamic> json) {
    return AutoChoiceLocationModel(
      city: City.fromJson(json['city']),
      continent: Continent.fromJson(json['continent']),
      country: Country.fromJson(json['country']),
      location: Location.fromJson(json['location']),
      subdivisions: (json['subdivisions'] as List<dynamic>)
          .map((e) => Subdivision.fromJson(e))
          .toList(),
      state: StateData.fromJson(json['state']),
      datasource: (json['datasource'] as List<dynamic>)
          .map((e) => Datasource.fromJson(e))
          .toList(),
      ip: json['ip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city.toJson(),
      'continent': continent.toJson(),
      'country': country.toJson(),
      'location': location.toJson(),
      'subdivisions': subdivisions.map((e) => e.toJson()).toList(),
      'state': state.toJson(),
      'datasource': datasource.map((e) => e.toJson()).toList(),
      'ip': ip,
    };
  }
}

class City {
  final Map<String, String> names;
  final String name;

  City({
    required this.names,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      names: Map<String, String>.from(json['names']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'names': names,
      'name': name,
    };
  }
}

class Continent {
  final String code;
  final int geonameId;
  final Map<String, String> names;
  final String name;

  Continent({
    required this.code,
    required this.geonameId,
    required this.names,
    required this.name,
  });

  factory Continent.fromJson(Map<String, dynamic> json) {
    return Continent(
      code: json['code'],
      geonameId: json['geoname_id'],
      names: Map<String, String>.from(json['names']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'geoname_id': geonameId,
      'names': names,
      'name': name,
    };
  }
}

class Country {
  final int geonameId;
  final String isoCode;
  final Map<String, String> names;
  final String name;
  final String nameNative;
  final String phoneCode;
  final String capital;
  final String currency;
  final String flag;
  final List<Language> languages;

  Country({
    required this.geonameId,
    required this.isoCode,
    required this.names,
    required this.name,
    required this.nameNative,
    required this.phoneCode,
    required this.capital,
    required this.currency,
    required this.flag,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      geonameId: json['geoname_id'],
      isoCode: json['iso_code'],
      names: Map<String, String>.from(json['names']),
      name: json['name'],
      nameNative: json['name_native'],
      phoneCode: json['phone_code'],
      capital: json['capital'],
      currency: json['currency'],
      flag: json['flag'],
      languages: (json['languages'] as List<dynamic>)
          .map((e) => Language.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geoname_id': geonameId,
      'iso_code': isoCode,
      'names': names,
      'name': name,
      'name_native': nameNative,
      'phone_code': phoneCode,
      'capital': capital,
      'currency': currency,
      'flag': flag,
      'languages': languages.map((e) => e.toJson()).toList(),
    };
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Subdivision {
  final Map<String, String> names;

  Subdivision({
    required this.names,
  });

  factory Subdivision.fromJson(Map<String, dynamic> json) {
    return Subdivision(
      names: Map<String, String>.from(json['names']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'names': names,
    };
  }
}

class StateData {
  final String name;

  StateData({
    required this.name,
  });

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class Datasource {
  final String name;
  final String attribution;
  final String license;

  Datasource({
    required this.name,
    required this.attribution,
    required this.license,
  });

  factory Datasource.fromJson(Map<String, dynamic> json) {
    return Datasource(
      name: json['name'],
      attribution: json['attribution'],
      license: json['license'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'attribution': attribution,
      'license': license,
    };
  }
}

class Language {
  final String isoCode;
  final String name;
  final String nameNative;

  Language({
    required this.isoCode,
    required this.name,
    required this.nameNative,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      isoCode: json['iso_code'],
      name: json['name'],
      nameNative: json['name_native'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_code': isoCode,
      'name': name,
      'name_native': nameNative,
    };
  }
}
