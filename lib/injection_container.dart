import 'package:cbs_test/features/home/data/datasources/census_remote_datasource.dart';
import 'package:cbs_test/features/home/data/repositories/census_repository_impl.dart';
import 'package:cbs_test/features/home/domain/repositories/census_repository.dart';
import 'package:cbs_test/features/home/domain/usecases/get_district_census_data_usecase.dart';
import 'package:cbs_test/features/home/domain/usecases/get_municipality_census_data_usecase.dart';
import 'package:cbs_test/features/home/domain/usecases/get_province_census_data_usecase.dart';
import 'package:cbs_test/features/home/presentation/bloc/census_bloc/census_bloc.dart';
import 'package:cbs_test/features/home/presentation/bloc/drop_down_bloc/drop_down_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/home/domain/usecases/get_geograhical_census_data_usecase.dart';

GetIt sl=GetIt.instance;

Future<void> init() async{
  
  sl.registerFactory<CensusBloc>(() => CensusBloc(geographicalCensusData: sl(), provinceCensusData: sl(), districtCensusData: sl(), municipalityCensusData: sl()));
  sl.registerFactory<DropDownBloc>(() => DropDownBloc(getGeographicalCensusData: sl(), getProvinceCensusData: sl(), getDistrictCensusData: sl(), getMunicipalityCensusData: sl()));

  //usecase
  sl.registerLazySingleton(() => GetDistrictCensusData(censusRepository: sl()));
  sl.registerLazySingleton(() => GetGeographicalCensusData(censusRepository: sl()));
  sl.registerLazySingleton(() => GetProvinceCensusData(censusRepository: sl()));
  sl.registerLazySingleton(() => GetMunicipalityCensusData(censusRepository: sl()));

  //repositories
  sl.registerLazySingleton<CensusRepository>(() => CensusRepositoryImpl(remoteDataSouce: sl()));

  //datasources
  sl.registerLazySingleton<CensusRemoteDataSouce>(() => CensusRemoteDataSourceImpl(dio: sl()));


  //external
  sl.registerLazySingleton(() => Dio());
  
}