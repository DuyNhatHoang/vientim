// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../../../../../common/size_config.dart';
import '../../../../models/provice.dart';

class ProvinceSelectBody extends StatefulWidget {
  final Function(Province) onSuccess;
  final Provinces province;
  const ProvinceSelectBody({Key key, this.onSuccess, this.province}) : super(key: key);

  @override
  _ProvinceSelectBodyState createState() => _ProvinceSelectBodyState();
}

class _ProvinceSelectBodyState extends State<ProvinceSelectBody> {
  int val = -1;
  Province province;
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
                          (province);
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
    return widget.province.provinces.map((e) =>
        MediaQuery.removePadding(context: context,
            removeLeft: true,
            child: ListTile(
          title: Text(e.label, style: const TextStyle(color: Colors.black),),
          leading: Radio(
            value: int.parse(e.value.toString()),
            groupValue: val,
            onChanged: (value) {
              setState(() {
                print("value $value");
                val = value as int;
                province = e;
              });
            },
            activeColor: Colors.green,
          ),
        ))
    ).toList();
  }
}
