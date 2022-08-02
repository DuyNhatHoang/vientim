
// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:flutter/material.dart';

// ignore: avoid_types_as_parameter_names
void showGenderSelectDialog(BuildContext context, Function onSuccessTap(int)){
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
          ),
          child: SelectDialogBody(
            onSuccess: (int val){
              onSuccessTap(val);
        },
          )
        ),
      );
    },
  );
}

class SelectDialogBody extends StatefulWidget {
  final Function(int) onSuccess;
  const SelectDialogBody({Key key, this.onSuccess}) : super(key: key);

  @override
  _SelectDialogBodyState createState() => _SelectDialogBodyState();
}

class _SelectDialogBodyState extends State<SelectDialogBody> {
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        child: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: const Text("Nam"),
                leading: Radio(
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value as int;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
              ListTile(
                title: const Text("Nữ"),
                leading: Radio(
                  value: 2,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value as int;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
              const SizedBox(height: 10,),
              const Divider(color: Colors.black, height: 1,),
              const SizedBox(height: 10),
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
                          width: 100,
                          child: const Center(
                            child: Text("Hủy bỏ", style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,

                            )),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        widget.onSuccess
                          (val);
                      },

                      child: Container(
                          decoration: const BoxDecoration(
                          ),
                          width: 100,
                          child: const Center(
                            child: Text("Đồng ý", style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
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
}
