import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../domain/entities/census.dart';

class GridContainer extends StatefulWidget {
   GridContainer({Key? key,required this.locale,required this.census}) : super(key: key);

  String locale;
  dynamic census;

  @override
  State<GridContainer> createState() => _GridContainerState();
}

class _GridContainerState extends State<GridContainer> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        boxShadow: const [
           BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color:Colors.white60,
      ),
      margin:EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.locale,style: TextStyle(fontWeight: FontWeight.bold),),
          Text(widget.census.toString()),
        ],
      ),
    );
  }
}
