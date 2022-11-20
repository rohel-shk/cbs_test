// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "title": "Preliminary Report of National Census 2078",
  "household": "Households",
  "females": "Females",
  "male": "Males",
  "families": "Families",
  "geography": "Geography",
  "province": "Province",
  "district": "District",
  "municipalities": "Municipalities",
  "select_district_error": "Please select district first",
  "select_province_error": "Please select province first",
  "select_geography": "Select Geography",
  "select_province": "Select Province",
  "select_district": "Select District",
  "select_municipality": "Select Municipality",
  "total_population": "Total Population",
  "gender_ratio": "Gender Ratio"
};
static const Map<String,dynamic> ne = {
  "title": "राष्ट्रिय जनगणना २०७८ को प्रारम्भिक प्रतिवेदन",
  "household": "घरपरिवारहरू",
  "females": "महिलाहरू",
  "male": "पुरुष",
  "families": "परिवारहरू",
  "geography": "भूगोल",
  "province": "प्रान्त",
  "district": "जिल्ला",
  "municipalities": "नगरपालिकाहरू",
  "select_district_error": "कृपया पहिले जिल्ला चयन गर्नुहोस्",
  "select_province_error": "कृपया पहिले प्रदेश चयन गर्नुहोस्",
  "select_geography": "भूगोल चयन गर्नुहोस्",
  "select_province": "प्रान्त चयन गर्नुहोस्",
  "select_district": "जिल्ला चयन गर्नुहोस्",
  "select_municipality": "नगरपालिका चयन गर्नुहोस्",
  "total_population": "कुल जनसंख्या",
  "gender_ratio": "लिङ्ग अनुपात"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ne": ne};
}
