import 'dart:convert';

import 'package:cbs_test/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

import '../models/census_model.dart';


abstract class CensusRemoteDataSouce{
  Future<List<CensusModel>> getGeographicalCensusData();
  Future<List<CensusModel>> getProvinceCensusData();
  Future<List<CensusModel>> getDistrictCensusData();
  Future<List<CensusModel>> getMunicipalityCensusData();
}

class CensusRemoteDataSourceImpl implements CensusRemoteDataSouce{

  final Dio dio;

  CensusRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CensusModel>> getDistrictCensusData() async{
    List<CensusModel> districtData=[];
    final response=await Dio().getUri(Uri.parse('http://census-report-api.caprover.staging.yipl.com.np/api/districts'));
    if(response.statusCode==200){
      List data=response.data;
      data.forEach((value) {
        value.forEach((key,value){
          districtData.add(CensusModel.fromJson(value));
        });
      });
      return districtData;
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<List<CensusModel>> getGeographicalCensusData() async{
    List<CensusModel> geoData=[];
    final response=await dio.getUri(Uri.parse('http://census-report-api.caprover.staging.yipl.com.np/api/geographies'));
    if(response.statusCode==200){
      List data=response.data;
      data.forEach((value) {
        value.forEach((key,value){
          geoData.add(CensusModel.fromJson(value));
        });
      });
      return geoData;
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<List<CensusModel>> getMunicipalityCensusData() async{
    List<CensusModel> municipalityData=[];
    final response=await Dio().getUri(Uri.parse('http://census-report-api.caprover.staging.yipl.com.np/api/locallevels'));
    if(response.statusCode==200){
      List data=response.data;
      data.forEach((value) {
        value.forEach((key,value){
          municipalityData.add(CensusModel.fromJson(value));
        });
      });
      return municipalityData;
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<List<CensusModel>> getProvinceCensusData() async{
    List<CensusModel> provinceData=[];
    final response=await Dio().getUri(Uri.parse('http://census-report-api.caprover.staging.yipl.com.np/api/provinces'));
    if(response.statusCode==200){
      List data=response.data;
      data.forEach((value) {
        value.forEach((key,value){
          provinceData.add(CensusModel.fromJson(value));
        });
      });
      return provinceData;
    }
    else{
      throw ServerException();
    }
  }

}