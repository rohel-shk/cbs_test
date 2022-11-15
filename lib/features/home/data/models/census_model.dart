import 'package:cbs_test/features/home/domain/entities/census.dart';

class CensusModel extends Census{
  CensusModel({required super.id, required super.slug, required super.name, required super.nameInNepali, required super.households, required super.families, required super.totalPopulation, required super.male, required super.female, required super.genderRatio,super.district,super.avgFamilySize,super.growthRate,super.populationDensity,super.province,super.totalPopulation2068});


  factory CensusModel.fromJson(Map<String,dynamic> json){
    return CensusModel(id: json['id'], slug: json['slug'], name: json['name'], nameInNepali: json['name_in_nepali'], households: json['households'], families: json['families'], totalPopulation: json['total_population'], male: json['male'], female: json['female'], genderRatio: json['gender_ratio'],district: json['district'],avgFamilySize: json['average_family_size'],growthRate: json['growth_rate'],populationDensity: json['population_density'],province: json['province']);
  }

}

