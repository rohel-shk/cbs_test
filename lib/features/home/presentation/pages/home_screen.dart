import 'package:cbs_test/features/home/presentation/bloc/census_bloc/census_bloc.dart';
import 'package:cbs_test/features/home/presentation/bloc/drop_down_bloc/drop_down_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
             return SimpleDialog(
               children: [Text('Please select Province first')],
             );
           }
           if(state is DropDownMunicipalityError){
             return SimpleDialog(
               children: [Text('Please select district first')],
             );
           }
           if(state is GeographicCensusLoaded){
            return SimpleDialog(
            title: Text('Select $dropDownTitle'),
            children: [
              SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.geoList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                    itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        setState((){
                        currentSlug=state.geoList[index].slug;
                        });
                        if(dropDownTitle=='Province'){
                            selectedProvince=state.geoList[index].slug;
                        context.read<CensusBloc>().add(GetProvinceCensusDataEvent());

                        }
                        else if(dropDownTitle=='District'){
                          selectedDistrict=state.geoList[index].slug;
                        context.read<CensusBloc>().add(GetDistrictCensusDataEvent(key: selectedProvince));
                        }
                        else if(dropDownTitle=='Municipalities'){
                          selectedMunicipal=state.geoList[index].slug;
                          context.read<CensusBloc>().add(GetMunicipalitiesCensusDataEvent(key: selectedDistrict));
                        }
                        else{
                          selectedGeo==state.geoList[index].slug;
                        context.read<CensusBloc>().add(GetGeographicsCensusDataEvent(key: state.geoList[index].slug));

                        }
                        Navigator.pop(context);
                      },
                      title: Text('${state.geoList[index].name}'),);
                }),
              )
            ],
          );
           }
           else{
             return Center();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CensusBloc>().add(GetGeographicsCensusDataEvent(key: 'overall'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade700,
        title: RichText(
            text: TextSpan(
              text: 'Preliminary report of National Census 2078',
                  style: TextStyle(fontSize: 20)
            ),
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
                                dropDownTitle[index]=='Province'?selectedProvince==''?
                                '${dropDownTitle[index]}':'${selectedProvince}':dropDownTitle[index]=='District'?selectedDistrict==''?'${dropDownTitle[index]}':'${selectedDistrict}':
                                dropDownTitle[index]=='Municipalities'?selectedMunicipal==''?'${dropDownTitle[index]}':'${selectedMunicipal}':selectedGeo==''?'${dropDownTitle[index]}':'$selectedGeo}',
                                overflow: TextOverflow.ellipsis,),
                            Icon(Icons.arrow_drop_down_outlined)
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
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text('${census.name}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 20),
                          Expanded(
                            child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                             children: [
                               Container(
                                 margin:EdgeInsets.all(10),
                                 padding: EdgeInsets.all(10),
                                 child: Column(
                                   children: [
                                     Text('Household',style: TextStyle(fontWeight: FontWeight.bold),),
                                     Text('${census.households}'),
                                   ],
                                 ),
                               ),
                               Container(
                                 margin:EdgeInsets.all(10),
                                 padding: EdgeInsets.all(10),
                                 child: Column(
                                   children: [
                                     Text('Females',style: TextStyle(fontWeight: FontWeight.bold),),
                                     Text('${census.female}'),
                                   ],
                                 ),
                               ),
                               Container(
                                 margin:EdgeInsets.all(10),
                                 padding: EdgeInsets.all(10),
                                 child: Column(
                                   children: [
                                     Text('Males',style: TextStyle(fontWeight: FontWeight.bold),),
                                     Text('${census.male}'),
                                   ],
                                 ),
                               ),
                               Container(
                                 margin:EdgeInsets.all(10),
                                 padding: EdgeInsets.all(10),
                                 child: Column(
                                   children: [
                                     Text('Families',style: TextStyle(fontWeight: FontWeight.bold),),
                                     Text('${census.families}'),
                                   ],
                                 ),
                               ),

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

