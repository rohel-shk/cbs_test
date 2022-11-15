part of 'census_bloc.dart';

@immutable
abstract class CensusEvent extends Equatable{}

class GetGeographicsCensusDataEvent extends CensusEvent{

 final String key;

  GetGeographicsCensusDataEvent({required this.key});

  @override
  // TODO: implement props
  List<Object?> get props => [key];

}

class GetProvinceCensusDataEvent extends CensusEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetDistrictCensusDataEvent extends CensusEvent{

  final String key;

  GetDistrictCensusDataEvent({required this.key});

  @override
  // TODO: implement props
  List<Object?> get props => [key];
}

class GetMunicipalitiesCensusDataEvent extends CensusEvent{

  final String key;

  GetMunicipalitiesCensusDataEvent({required this.key});

  @override
  // TODO: implement props
  List<Object?> get props => [key];


}
