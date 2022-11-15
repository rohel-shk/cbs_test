part of 'census_bloc.dart';

@immutable
abstract class CensusState extends Equatable{}

class CensusInitial extends CensusState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CensusDataLoading extends CensusState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CensusLoaded extends CensusState{

  final List<Census> census;

  CensusLoaded({required this.census});

  @override
  // TODO: implement props
  List<Object?> get props => [census];

}

class CensusError extends CensusState{

  final String message;

  CensusError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
