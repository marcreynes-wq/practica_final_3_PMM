import 'dart:convert';

class PlantResponse {
  final List<Plant> data;

  PlantResponse({required this.data});

  factory PlantResponse.fromJson(String str) =>
      PlantResponse.fromMap(json.decode(str));

  factory PlantResponse.fromMap(Map<String, dynamic> json) => PlantResponse(
        data: List<Plant>.from(
            (json["data"] ?? []).map((x) => Plant.fromMap(x))),
      );
}

class Plant {
  final int id;
  final String commonName;
  final List<String> scientificName;
  final DefaultImage? defaultImage;
  final String? watering;
  final String? sunlight;
  final String? cycle;

  Plant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    this.defaultImage,
    this.watering,
    this.sunlight,
    this.cycle,
  });

  factory Plant.fromMap(Map<String, dynamic> json) => Plant(
        id: json["id"] ?? 0,
        commonName: json["common_name"] ?? 'Nombre no disponible',
        scientificName: json["scientific_name"] != null
            ? List<String>.from(json["scientific_name"].map((x) => x.toString()))
            : ['Sin nombre científico'],
        defaultImage: json["default_image"] != null
            ? DefaultImage.fromMap(json["default_image"])
            : null,
        watering: json["watering"] ?? 'No especificado',
        sunlight: json["sunlight"] != null
            ? (json["sunlight"] is List
                ? (json["sunlight"] as List).join(', ')
                : json["sunlight"].toString())
            : 'No especificado',
        cycle: json["cycle"] ?? 'No especificado',
      );

  String get fullImageUrl {
    if (defaultImage?.originalUrl != null && defaultImage!.originalUrl!.isNotEmpty) {
      return defaultImage!.originalUrl!;
    }
    return '[suspicious link removed]';
  }
}

class DefaultImage {
  final int? license;
  final String? licenseName;
  final String? licenseUrl;
  final String? originalUrl;
  final String? regularUrl;

  DefaultImage({
    this.license,
    this.licenseName,
    this.licenseUrl,
    this.originalUrl,
    this.regularUrl,
  });

  factory DefaultImage.fromMap(Map<String, dynamic> json) => DefaultImage(
        license: json["license"],
        licenseName: json["license_name"],
        licenseUrl: json["license_url"],
        originalUrl: json["original_url"],
        regularUrl: json["regular_url"],
      );
}