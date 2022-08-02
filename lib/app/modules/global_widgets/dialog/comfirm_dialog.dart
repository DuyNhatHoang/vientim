import 'package:flutter/material.dart';
import '../../../../common/size_config.dart';

void showComfirmDialog(BuildContext context, String comfirmText, {Function onSuccessTap}){
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(0),
        contentPadding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.02),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.screenWidth * 0.05))
        ),
        content: SizedBox(
            height: SizeConfig.screenHeight * 0.14,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03,),
              Text(comfirmText, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
             SizedBox(height: SizeConfig.screenHeight * 0.03,),
             const Divider(color: Colors.black, height: 1,),
             Expanded(
               child:  Row(
                 children: [
                   InkWell(
                     onTap: (){
                       Navigator.of(context).pop();
                     },
                     child: Container(
                       decoration: const BoxDecoration(
                         border: Border(
                           right: BorderSide(
                             color: Colors.black,
                             width: 0.2
                           )
                         )
                       ),
                         width: SizeConfig.screenWidth * 0.4,
                         child: Center(
                           child: Text("Hủy bỏ", style: TextStyle(
                               color: Colors.blue,
                               fontSize: SizeConfig.screenWidth * 0.045,
                             
                           )),
                         )
                     ),
                   ),
                   InkWell(
                     onTap: (){
                       Navigator.of(context).pop();
                       onSuccessTap();
                     },

                     child: Container(
                         decoration: const BoxDecoration(
                             border: Border(
                                 left: BorderSide(
                                     color: Colors.black,
                                     width: 0.2
                                 )
                             )
                         ),
                         width: SizeConfig.screenWidth * 0.4,
                         child: Center(
                           child: Text("OK", style: TextStyle(
                             color: Colors.blue,
                             fontSize: SizeConfig.screenWidth * 0.045,
                             fontWeight: FontWeight.bold
                           ),),
                         )
                     ),
                   ),
                 ],
               ),
             )
            ],
          )
        ),
      );
    },
  );
}