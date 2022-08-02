// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import '../../../../../common/size_config.dart';
import '../../../../models/provice.dart';

class DistrictSelectBody extends StatefulWidget {
  final Function(Districts) onSuccess;
  final Province province;
  const DistrictSelectBody({Key key, this.onSuccess, this.province}) : super(key: key);

  @override
  _DistrictSelectBodyState createState() => _DistrictSelectBodyState();
}

class _DistrictSelectBodyState extends State<DistrictSelectBody> {
  int val = -1;
  Districts districts;
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.4)
        ),
        child: SizedBox(
          height: SizeConfig.screenHeight * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.screenHeight * 0.4,
                child: ListView(
                  children: lists(),
                ),
              ),

              SizedBox(height: SizeConfig.screenHeight * 0.01,),
              const Divider(color: Colors.black, height: 1,),
              SizedBox(height: SizeConfig.screenHeight * 0.02,),
              Expanded(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            // border: Border(
                            //     right: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.2
                            //     )
                            // )
                          ),
                          width: SizeConfig.screenWidth * 0.25,
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
                        widget.onSuccess
                          (districts);
                      },

                      child: Container(
                          decoration: const BoxDecoration(
                          ),
                          width: SizeConfig.screenWidth * 0.25,
                          child: Center(
                            child: Text("Đồng ý", style: TextStyle(
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
          ),
        )
    );
  }

  List<Widget> lists(){
    return widget.province.districts.map((e) =>
        MediaQuery.removePadding(context: context,
            removeLeft: true,
            child: ListTile(
          title: Text(e.label, style: const TextStyle(color: Colors.black),),
          leading: Radio(
            value: int.parse(e.value.toString()),
            groupValue: val,
            onChanged: (value) {
              setState(() {
                print("value ${value}");
                val = value as int;
                districts = e;
              });
            },
            activeColor: Colors.green,
          ),
        ))
    ).toList();
  }
}
