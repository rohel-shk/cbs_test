import 'package:cbs_test/core/errors/exceptions.dart';
import 'package:cbs_test/core/errors/failures.dart';
import 'package:cbs_test/features/home/data/datasources/census_remote_datasource.dart';
import 'package:cbs_test/features/home/domain/entities/census.dart';
import 'package:cbs_test/features/home/domain/repositories/census_repository.dart';
import 'package:dartz/dartz.dart';

class CensusRepositoryImpl implements CensusRepository{

  final CensusRemoteDataSouce remoteDataSouce;

  CensusRepositoryImpl({required this.remoteDataSouce});

  @override
  Future<Either<Failure, List<Census>>> getDistrictCensusData() async{
    try{
      final response=await remoteDataSouce.getDistrictCensusData();
      return Right(response);
    }on ServerException{
      return Left(ServerFailure());
    }

  }

  @override
  Future<Either<Failure, List<Census>>> getGeographicalCensusData() async{
    try{
      final response=await remoteDataSouce.getGeographicalCensusData();
      return Right(response);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Census>>> getMunicipalitiesCensusData() async{
      try{
        final response=await remoteDataSouce.getMunicipalityCensusData();
        return Right(response);
      }on ServerException{
        return Left(ServerFailure());
      }
  }

  @override
  Future<Either<Failure, List<Census>>> getProvinceCensusData() async{
    try{
      final response=await remoteDataSouce.getProvinceCensusData();
      return Right(response);
    }on ServerException{
      return Left(ServerFailure());
    }
  }
}