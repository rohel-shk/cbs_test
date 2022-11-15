import 'package:cbs_test/core/errors/failures.dart';
import 'package:cbs_test/core/usecase/usecase.dart';
import 'package:cbs_test/features/home/domain/repositories/census_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/census.dart';

class GetProvinceCensusData implements Usecase<List<Census>,NoParams> {
  final CensusRepository censusRepository;

  GetProvinceCensusData({required this.censusRepository});

  @override
  Future<Either<Failure, List<Census>>> call(NoParams params) async {
    return await censusRepository.getProvinceCensusData();
  }
}

