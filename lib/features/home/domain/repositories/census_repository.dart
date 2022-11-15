import 'package:cbs_test/features/home/domain/entities/census.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class CensusRepository{

  Future<Either<Failure,List<Census>>> getGeographicalCensusData();
  Future<Either<Failure,List<Census>>> getProvinceCensusData();
  Future<Either<Failure,List<Census>>> getDistrictCensusData();
  Future<Either<Failure,List<Census>>> getMunicipalitiesCensusData();
}