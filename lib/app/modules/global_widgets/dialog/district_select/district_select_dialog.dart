// ignore_for_file: use_function_type_syntax_for_parameters, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../../../../common/size_config.dart';
import '../../../../models/provice.dart';
import 'body.dart';

void showDistrictSelectDialog(BuildContext context,Province province, Function onSuccessTap(Districts)){

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
          child: DistrictSelectBody(
            province: province,
            onSuccess: (val){
              onSuccessTap(val);
        },
          )
        ),
      );
    },
  );
}