import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/locale_keys.g.dart';
import '../bloc/census_bloc/census_bloc.dart';
import '../bloc/drop_down_bloc/drop_down_bloc.dart';

class DialogList extends StatefulWidget {

  String currentSlug='overall';
  String selectedProvince='';
  String selectedDistrict='';
  String selectedGeo='';
  String selectedMunicipal='';
  String selectedProvinceName='';
  String selectedDistrictName='';
  String selectedGeoName='';
  String selectedMunicipalName='';
  String dropDownTitle='';

  DialogList({Key? key,required this.dropDownTitle}) : super(key: key);

  @override
  State<DialogList> createState() => _DialogListState();
}

class _DialogListState extends State<DialogList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropDownBloc, DropDownState>(
        builder: (context, state) {
          if(state is DropDownDistrictError){
            return  SimpleDialog(
              contentPadding: const EdgeInsets.all(20),
              children: [Text(LocaleKeys.select_province_error.tr())],
            );
          }
          if(state is DropDownMunicipalityError){
            return  SimpleDialog(
              contentPadding: const EdgeInsets.all(20),
              children: [Text(LocaleKeys.select_district_error.tr())],
            );
          }
          if(state is GeographicCensusLoaded){
            return SimpleDialog(
              title: Text('${widget.dropDownTitle=='Province'?LocaleKeys.select_province.tr():widget.dropDownTitle=='District'?LocaleKeys.select_district.tr():widget.dropDownTitle=='Geography'?LocaleKeys.select_geography.tr():widget.dropDownTitle=='Municipalities'?LocaleKeys.select_municipality.tr():''}'),
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.geoList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return ListTile(
                            onTap: (){
                              setState((){
                                widget.currentSlug=state.geoList[index].slug;
                              });
                              if(widget.dropDownTitle=='Province'){
                                widget.selectedProvince=state.geoList[index].slug;
                                widget.selectedProvinceName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
                                context.read<CensusBloc>().add(GetProvinceCensusDataEvent());

                              }
                              else if(widget.dropDownTitle=='District'){
                                widget.selectedDistrict=state.geoList[index].slug;
                                widget.selectedDistrictName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
                                context.read<CensusBloc>().add(GetDistrictCensusDataEvent(key: widget.selectedProvince));
                              }
                              else if(widget.dropDownTitle=='Municipalities'){
                                widget.selectedMunicipal=state.geoList[index].slug;
                                widget.selectedMunicipalName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
                                context.read<CensusBloc>().add(GetMunicipalitiesCensusDataEvent(key: widget.selectedDistrict));
                              }
                              else{
                                widget.selectedGeo=state.geoList[index].slug;
                                widget.selectedGeoName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
                                context.read<CensusBloc>().add(GetGeographicsCensusDataEvent(key: state.geoList[index].slug));

                              }
                              Navigator.pop(context);
                            },
                            title: Text(context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali),);
                        }),
                  ),
                )
              ],
            );
          }
          else{
            return const Center();

          }
        }
    );
  }
}
