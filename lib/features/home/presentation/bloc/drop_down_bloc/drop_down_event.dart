part of 'drop_down_bloc.dart';

@immutable
abstract class DropDownEvent {}


class GetGeographicalListEvent extends DropDownEvent{

}

class GetProvinceListEvent extends DropDownEvent{

}

class GetDistrictListEvent extends DropDownEvent{
  final String key;
  GetDistrictListEvent({required this.key});
}

class GetMunicipalitiesListEvent extends DropDownEvent{
  final String key;
  GetMunicipalitiesListEvent({required this.key});

}

