import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cbs_test/core/usecase/usecase.dart';
import 'package:cbs_test/features/home/domain/usecases/get_district_census_data_usecase.dart';
import 'package:cbs_test/features/home/domain/usecases/get_municipality_census_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/census.dart';
import '../../../domain/usecases/get_geograhical_census_data_usecase.dart';
import '../../../domain/usecases/get_province_census_data_usecase.dart';

part 'census_event.dart';
part 'census_state.dart';

class CensusBloc extends Bloc<CensusEvent, CensusState> {

  final GetGeographicalCensusData geographicalCensusData;
  final GetProvinceCensusData provinceCensusData;
  final GetDistrictCensusData districtCensusData;
  final GetMunicipalityCensusData municipalityCensusData;

  CensusBloc({required this.municipalityCensusData, required this.districtCensusData, required this.provinceCensusData, required this.geographicalCensusData}) : super(CensusInitial()) {
    on<CensusEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetGeographicsCensusDataEvent>((event, emit) async=> await _geographicalCensusData(event, emit));
    on<GetProvinceCensusDataEvent>((event, emit) async=> await _provinceCensusData(event, emit));
    on<GetDistrictCensusDataEvent>((event, emit) async=> await _districtCensusData(event, emit));
    on<GetMunicipalitiesCensusDataEvent>((event, emit) async=> await _municipalitiesCensusData(event, emit));
  }

  Future<void> _geographicalCensusData(GetGeographicsCensusDataEvent event,Emitter<CensusState> emit) async {
      emit(CensusDataLoading());
      final response=await geographicalCensusData(NoParams());
      await response.fold((failure) async=> emit(CensusError(message: 'Server Failure')), (census) async{
        // Census overallCensus=census.firstWhere((element) => element.slug==event.key);
        // emit(CensusLoaded(census: overallCensus));
        emit(CensusLoaded(census: census));
      });
  }

  Future<void> _provinceCensusData(GetProvinceCensusDataEvent event,Emitter<CensusState> emit) async {
    emit(CensusDataLoading());
    final response=await provinceCensusData(NoParams());
    await response.fold((failure) async=> emit(CensusError(message: 'Server Failure')), (census) async{
      // Census overallCensus=census.firstWhere((element) => element.slug==event.key);
      // emit(CensusLoaded(census: overallCensus));
      emit(CensusLoaded(census: census));
    });
  }

  Future<void> _districtCensusData(GetDistrictCensusDataEvent event,Emitter<CensusState> emit) async {
    emit(CensusDataLoading());
    final response=await districtCensusData(NoParams());
    await response.fold((failure) async=> emit(CensusError(message: 'Server Failure')), (census) async{
      // Census overallCensus=census.firstWhere((element) => element.slug==event.key);
      // emit(CensusLoaded(census: overallCensus));
      emit(CensusLoaded(census: census));
    });
  }

  Future<void> _municipalitiesCensusData(GetMunicipalitiesCensusDataEvent event,Emitter<CensusState> emit) async {
    emit(CensusDataLoading());
    final response=await municipalityCensusData(NoParams());
    await response.fold((failure) async=> emit(CensusError(message: 'Server Failure')), (census) async{
      // Census overallCensus=census.firstWhere((element) => element.slug==event.key);
      // emit(CensusLoaded(census: overallCensus));
      emit(CensusLoaded(census: census));
    });
  }
}
