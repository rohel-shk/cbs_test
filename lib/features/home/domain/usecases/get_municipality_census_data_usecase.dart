import 'package:cbs_test/core/errors/failures.dart';
import 'package:cbs_test/core/usecase/usecase.dart';
import 'package:cbs_test/features/home/domain/entities/census.dart';
import 'package:cbs_test/features/home/domain/repositories/census_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetMunicipalityCensusData implements Usecase<List<Census>,NoParams>{


  final CensusRepository censusRepository;

  GetMunicipalityCensusData({required this.censusRepository});

  @override
  Future<Either<Failure, List<Census>>> call(NoParams noParams) async{
    return await censusRepository.getMunicipalitiesCensusData();
  }

}

class MunicipalityParams extends Equatable{
  final String district;

  MunicipalityParams({required this.district});

  @override
  // TODO: implement props
  List<Object?> get props => [district];
}