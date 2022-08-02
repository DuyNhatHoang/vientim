
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../../../common/size_config.dart';
import '../../../../models/provice.dart';
import 'body.dart';
// ignore: use_function_type_syntax_for_parameters, avoid_types_as_parameter_names
void showProvinceSelectDialog(BuildContext context,Provinces provinces, Function onSuccessTap(Province)){
  SizeConfig().init(context);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.screenWidth * 0.05))
        ),
        // insetPadding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.2),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.4)
          ),
          child: ProvinceSelectBody(
            province: provinces,
            onSuccess: (val){
              onSuccessTap(val);
        },
          )
        ),
      );
    },
  );
}