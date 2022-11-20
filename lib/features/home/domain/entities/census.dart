class Census{
  final int id;
  final String slug;
  final String name;
  final String nameInNepali;
  final dynamic households;
  final dynamic families;
  final dynamic totalPopulation;
  final dynamic male;
  final dynamic female;
  final double genderRatio;
  final dynamic avgFamilySize;
  final dynamic  growthRate;
  final dynamic  populationDensity;
  final dynamic  totalPopulation2068;
  final String? province;
  final String? district;

  Census({required this.id, required this.slug, required this.name, required this.nameInNepali, required this.households, required this.families, required this.totalPopulation, required this.male, required this.female, required this.genderRatio, this.avgFamilySize, this.growthRate, this.populationDensity, this.totalPopulation2068, this.province, this.district});
}