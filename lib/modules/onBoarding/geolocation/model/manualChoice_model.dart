// class PositionInfo {
//   final String? region;
//   final String? country;
//   final double latitude;
//   final double longitude;
//   final bool isPrecise;

//   PositionInfo(
//       {this.region,
//       this.country,
//       required this.latitude,
//       required this.longitude,
//       required this.isPrecise});

//   factory PositionInfo.fromJson(Map<String, dynamic> json) {
//     return PositionInfo(
//       region: json['region'] ?? '',
//       country: json['country'] ?? '',
//       latitude: json['latitude'] as double,
//       longitude: json['longitude'] as double,
//       isPrecise: json['isPrecise'] as bool,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'region': region,
//         'country': country,
//         'latitude': latitude,
//         'longitude': longitude,
//         'isPrecise': isPrecise,
//       };

//   @override
//   String toString() {
//     return '$region, $country';
//   }
// }

class ManualChoserModel {
  String? type;
  List<Features>? features;
  Query? query;

  ManualChoserModel({this.type, this.features, this.query});

  ManualChoserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (query != null) {
      data['query'] = query!.toJson();
    }
    return data;
  }
}

class Features {
  String? type;
  Properties? properties;
  Geometry? geometry;
  List<double>? bbox;

  Features({this.type, this.properties, this.geometry, this.bbox});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    geometry = json['geometry'] != null
        ? Geometry.fromJson(json['geometry'])
        : null;
    bbox = json['bbox'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['bbox'] = bbox;
    return data;
  }
}

class Properties {
  String? country;
  String? countryCode;
  String? city;
  String? postcode;
  Datasource? datasource;
  double? lon;
  double? lat;
  int? population;
  String? resultType;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  String? category;
  Timezone? timezone;
  String? plusCode;
  String? plusCodeShort;
  Rank? rank;
  String? placeId;
  String? state;
  String? county;
  String? district;
  String? hamlet;
  String? stateCode;

  Properties(
      {this.country,
      this.countryCode,
      this.city,
      this.postcode,
      this.datasource,
      this.lon,
      this.lat,
      this.population,
      this.resultType,
      this.formatted,
      this.addressLine1,
      this.addressLine2,
      this.category,
      this.timezone,
      this.plusCode,
      this.plusCodeShort,
      this.rank,
      this.placeId,
      this.state,
      this.county,
      this.district,
      this.hamlet,
      this.stateCode});

  Properties.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    postcode = json['postcode'];
    datasource = json['datasource'] != null
        ? Datasource.fromJson(json['datasource'])
        : null;
    lon = json['lon'];
    lat = json['lat'];
    population = json['population'];
    resultType = json['result_type'];
    formatted = json['formatted'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    category = json['category'];
    timezone = json['timezone'] != null
        ? Timezone.fromJson(json['timezone'])
        : null;
    plusCode = json['plus_code'];
    plusCodeShort = json['plus_code_short'];
    rank = json['rank'] != null ? Rank.fromJson(json['rank']) : null;
    placeId = json['place_id'];
    state = json['state'];
    county = json['county'];
    district = json['district'];
    hamlet = json['hamlet'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['country_code'] = countryCode;
    data['city'] = city;
    data['postcode'] = postcode;
    if (datasource != null) {
      data['datasource'] = datasource!.toJson();
    }
    data['lon'] = lon;
    data['lat'] = lat;
    data['population'] = population;
    data['result_type'] = resultType;
    data['formatted'] = formatted;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['category'] = category;
    if (timezone != null) {
      data['timezone'] = timezone!.toJson();
    }
    data['plus_code'] = plusCode;
    data['plus_code_short'] = plusCodeShort;
    if (rank != null) {
      data['rank'] = rank!.toJson();
    }
    data['place_id'] = placeId;
    data['state'] = state;
    data['county'] = county;
    data['district'] = district;
    data['hamlet'] = hamlet;
    data['state_code'] = stateCode;
    return data;
  }
}

class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;

  Datasource({this.sourcename, this.attribution, this.license, this.url});

  Datasource.fromJson(Map<String, dynamic> json) {
    sourcename = json['sourcename'];
    attribution = json['attribution'];
    license = json['license'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourcename'] = sourcename;
    data['attribution'] = attribution;
    data['license'] = license;
    data['url'] = url;
    return data;
  }
}

class Timezone {
  String? name;
  String? offsetSTD;
  int? offsetSTDSeconds;
  String? offsetDST;
  int? offsetDSTSeconds;
  String? abbreviationSTD;
  String? abbreviationDST;

  Timezone(
      {this.name,
      this.offsetSTD,
      this.offsetSTDSeconds,
      this.offsetDST,
      this.offsetDSTSeconds,
      this.abbreviationSTD,
      this.abbreviationDST});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    offsetSTD = json['offset_STD'];
    offsetSTDSeconds = json['offset_STD_seconds'];
    offsetDST = json['offset_DST'];
    offsetDSTSeconds = json['offset_DST_seconds'];
    abbreviationSTD = json['abbreviation_STD'];
    abbreviationDST = json['abbreviation_DST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['offset_STD'] = offsetSTD;
    data['offset_STD_seconds'] = offsetSTDSeconds;
    data['offset_DST'] = offsetDST;
    data['offset_DST_seconds'] = offsetDSTSeconds;
    data['abbreviation_STD'] = abbreviationSTD;
    data['abbreviation_DST'] = abbreviationDST;
    return data;
  }
}

class Rank {
  int? confidence;
  int? confidenceCityLevel;
  String? matchType;

  Rank({this.confidence, this.confidenceCityLevel, this.matchType});

  Rank.fromJson(Map<String, dynamic> json) {
    confidence = json['confidence'];
    confidenceCityLevel = json['confidence_city_level'];
    matchType = json['match_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['confidence'] = confidence;
    data['confidence_city_level'] = confidenceCityLevel;
    data['match_type'] = matchType;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class Query {
  String? text;
  Parsed? parsed;

  Query({this.text, this.parsed});

  Query.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    parsed =
        json['parsed'] != null ? Parsed.fromJson(json['parsed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    if (parsed != null) {
      data['parsed'] = parsed!.toJson();
    }
    return data;
  }
}

class Parsed {
  String? city;
  String? expectedType;

  Parsed({this.city, this.expectedType});

  Parsed.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    expectedType = json['expected_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['expected_type'] = expectedType;
    return data;
  }
}
