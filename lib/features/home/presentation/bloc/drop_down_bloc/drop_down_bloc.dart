import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cbs_test/core/usecase/usecase.dart';
import 'package:cbs_test/features/home/domain/usecases/get_district_census_data_usecase.dart';
import 'package:cbs_test/features/home/domain/usecases/get_municipality_census_data_usecase.dart';
import 'package:cbs_test/features/home/domain/usecases/get_province_census_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/census.dart';
import '../../../domain/usecases/get_geograhical_census_data_usecase.dart';
part 'drop_down_event.dart';
part 'drop_down_state.dart';

class DropDownBloc extends Bloc<DropDownEvent, DropDownState> {

  final GetGeographicalCensusData getGeographicalCensusData;
  final GetProvinceCensusData getProvinceCensusData;
  final GetDistrictCensusData getDistrictCensusData;
  final GetMunicipalityCensusData getMunicipalityCensusData;


  DropDownBloc({required this.getMunicipalityCensusData, required this.getDistrictCensusData, required this.getProvinceCensusData, required this.getGeographicalCensusData}) : super(DropDownInitial()) {
    on<DropDownEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetGeographicalListEvent>((event, emit) async=> await _getGeoDownList(event, emit));
    on<GetProvinceListEvent>((event, emit) async=> await _getProvinceList(event, emit));
    on<GetDistrictListEvent>((event, emit) async=>await _getDistrictList(event, emit));
    on<GetMunicipalitiesListEvent>((event, emit) async=>await _getMunicipalityList(event, emit));
  }

  Future<void> _getGeoDownList(GetGeographicalListEvent event,Emitter<DropDownState> emit) async{
    emit(DropDownLoading());
    final response=await getGeographicalCensusData(NoParams());
    await response.fold((failure) async=> emit(DropDownError(message: 'Server Failure')), (census) async=> emit(GeographicCensusLoaded(geoList: census)));
  }

  Future<void> _getProvinceList(GetProvinceListEvent event,Emitter<DropDownState> emit) async{
    emit(DropDownLoading());
    final response=await getProvinceCensusData(NoParams());
    await response.fold((failure) async=> emit(DropDownError(message: 'Server Failure')), (census) async=> emit(GeographicCensusLoaded(geoList: census)) );
  }
  Future<void> _getDistrictList(GetDistrictListEvent event,Emitter<DropDownState> emit) async{
    if(event.key!=''){
      emit(DropDownLoading());
      final response=await getDistrictCensusData(NoParams());
      await response.fold((failure) async=> emit(DropDownError(message: 'Server Failure')), (census) async{
      var filterList=census.where((element) => element.province==event.key).toList();
      emit(GeographicCensusLoaded(geoList: filterList));
      }
      );
    }
    else{
      emit(DropDownDistrictError());
    }
  }

  Future<void> _getMunicipalityList(GetMunicipalitiesListEvent event,Emitter<DropDownState> emit) async{
    if(event.key!=''){
      emit(DropDownLoading());
      final response=await getMunicipalityCensusData(NoParams());
      await response.fold((failure) async=> emit(DropDownError(message: 'Server Failure')), (census) async{
      var filterList=census.where((element) => element.district==event.key).toList();
      emit(GeographicCensusLoaded(geoList: filterList));
      }
      );
    }
    else{
      emit(DropDownMunicipalityError());
    }
  }
}
