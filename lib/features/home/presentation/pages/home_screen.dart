import 'package:cbs_test/features/home/presentation/bloc/census_bloc/census_bloc.dart';
import 'package:cbs_test/features/home/presentation/bloc/drop_down_bloc/drop_down_bloc.dart';
import 'package:cbs_test/features/home/presentation/widgets/grid_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cbs_test/generated/locale_keys.g.dart';
import '../../domain/entities/census.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  void _showDialog(String dropDownTitle){
    showDialog(context: context, builder: (BuildContext context){
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
            title: Text('${dropDownTitle=='Province'?LocaleKeys.select_province.tr():dropDownTitle=='District'?LocaleKeys.select_district.tr():dropDownTitle=='Geography'?LocaleKeys.select_geography.tr():dropDownTitle=='Municipalities'?LocaleKeys.select_municipality.tr():''}'),
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
                          currentSlug=state.geoList[index].slug;
                          });
                          if(dropDownTitle=='Province'){
                              selectedProvince=state.geoList[index].slug;
                              selectedProvinceName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
                          context.read<CensusBloc>().add(GetProvinceCensusDataEvent());

                          }
                          else if(dropDownTitle=='District'){
                            selectedDistrict=state.geoList[index].slug;
                            selectedDistrictName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
                          context.read<CensusBloc>().add(GetDistrictCensusDataEvent(key: selectedProvince));
                          }
                          else if(dropDownTitle=='Municipalities'){
                            selectedMunicipal=state.geoList[index].slug;
                            selectedMunicipalName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
                            context.read<CensusBloc>().add(GetMunicipalitiesCensusDataEvent(key: selectedDistrict));
                          }
                          else{
                            selectedGeo=state.geoList[index].slug;
                            selectedGeoName=context.locale.toString()=='en'?state.geoList[index].name:state.geoList[index].nameInNepali;
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
    });
  }

  List<String> dropDownTitle=['Geography','Province','District','Municipalities'];
  String currentSlug='overall';
  String selectedProvince='';
  String selectedDistrict='';
  String selectedGeo='';
  String selectedMunicipal='';
  String selectedProvinceName='';
  String selectedDistrictName='';
  String selectedGeoName='';
  String selectedMunicipalName='';
  var dropdown_items = ['ने', 'EN'];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CensusBloc>().add(GetGeographicsCensusDataEvent(key: 'overall'));
  }

  @override
  Widget build(BuildContext context) {
  String? value=context.locale.toString()=='en'?'EN':'ने';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blueAccent.shade700,
          title: Row(
            children: [
              Image.asset('assets/images/ic_app_icon.png'),
              Expanded(child: Text(LocaleKeys.title.tr(),maxLines: 3,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),)),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                width: 67,
                height: 36,
                margin: EdgeInsets.all(5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: Icon(Icons.arrow_drop_down),
                    value: value,
                    items: dropdown_items.map((e) {
                      return DropdownMenuItem(value:e,child: Text(e));
                    }).toList(),
                    onChanged: (selectedItem) async {
                      setState(() {
                        value = selectedItem;
                      });
                      if (selectedItem == 'EN') {
                        await context.setLocale(
                          const Locale('en'),
                        );
                      } else {
                        await context.setLocale(
                          const Locale('ne'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,

              child:
                ListView.builder(
                    itemCount: dropDownTitle.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()
                    ),
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: () async{
                          if(dropDownTitle[index]=='Province'){
                          context.read<DropDownBloc>().add(GetProvinceListEvent());
                          }
                          else if(dropDownTitle[index]=='District'){
                            print(selectedProvince);
                          context.read<DropDownBloc>().add(GetDistrictListEvent(key: selectedProvince));
                          }
                          else if(dropDownTitle[index]=='Geography'){
                            print(selectedGeo);
                            context.read<DropDownBloc>().add(
                                GetGeographicalListEvent());
                          }
                          else{
                            print(selectedDistrict);
                            context.read<DropDownBloc>().add(GetMunicipalitiesListEvent(key: selectedDistrict));
                          }
                           _showDialog(dropDownTitle[index]);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0XFFFAFAFA),
                                border: Border.all(color: Colors.black38),
                                borderRadius:BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 7),
                            child: Row(children:
                            [
                              Text(
                                dropDownTitle[index]=='Geography'?selectedGeoName==''?LocaleKeys.geography.tr():selectedGeoName:dropDownTitle[index]=='Province'?selectedProvinceName==''?
                                LocaleKeys.province.tr():selectedProvinceName:dropDownTitle[index]=='District'?selectedDistrictName==''?LocaleKeys.district.tr():selectedDistrictName:
                                dropDownTitle[index]=='Municipalities'?selectedMunicipalName==''?LocaleKeys.municipalities.tr():selectedMunicipalName:'',
                                overflow: TextOverflow.ellipsis,),
                            const Icon(Icons.arrow_drop_down_outlined)
                            ])),
                      );
                    }),
            ),
            Expanded(
              child: BlocBuilder<CensusBloc,CensusState>(
                builder: (context,state){
                  if(state is CensusDataLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(state is CensusLoaded){
                    Census census=state.census.firstWhere((element) => element.slug==currentSlug);
                    return Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Text('${context.locale.toString()=='en'?census.name:census.nameInNepali}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 20),
                          Expanded(
                            child: GridView(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                             physics: BouncingScrollPhysics(
                               parent: AlwaysScrollableScrollPhysics()
                             ),
                             children: [
                              GridContainer(locale: LocaleKeys.household.tr(), census: census.households),
                               GridContainer(locale: LocaleKeys.females.tr(), census: census.female),
                               GridContainer(locale: 'Male', census: census.male),
                               GridContainer(locale: LocaleKeys.families.tr(), census: census.families),
                               GridContainer(locale: LocaleKeys.gender_ratio, census: census.genderRatio),
                              GridContainer(locale: LocaleKeys.total_population.tr(), census: census.totalPopulation)
                             ],
                                ),
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                    return Scaffold();
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

