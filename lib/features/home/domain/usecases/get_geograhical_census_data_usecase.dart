import 'package:cbs_test/core/errors/failures.dart';
import 'package:cbs_test/core/usecase/usecase.dart';
import 'package:cbs_test/features/home/domain/entities/census.dart';
import 'package:cbs_test/features/home/domain/repositories/census_repository.dart';
import 'package:dartz/dartz.dart';

class GetGeographicalCensusData implements Usecase<List<Census>,NoParams>{


  final CensusRepository censusRepository;

  GetGeographicalCensusData({required this.censusRepository});

  @override
  Future<Either<Failure, List<Census>>> call(NoParams params) async{
    return await censusRepository.getGeographicalCensusData();
  }

}