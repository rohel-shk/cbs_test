part of 'drop_down_bloc.dart';

@immutable
abstract class DropDownState extends Equatable{}

class DropDownInitial extends DropDownState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}



class GeographicCensusLoaded extends DropDownState{

  final List<Census> geoList;

  GeographicCensusLoaded({required this.geoList});
  @override
  // TODO: implement props
  List<Object?> get props => [geoList];


}

class DropDownLoading extends DropDownState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class DropDownError extends DropDownState{
  final String message;

  DropDownError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class DropDownDistrictError extends DropDownState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class DropDownMunicipalityError extends DropDownState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
