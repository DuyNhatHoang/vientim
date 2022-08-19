import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/no_data_page.dart';
import 'package:vkhealth/app/modules/search/controllers/search_controller.dart';

import '../../../../common/app_constant.dart';
import '../../../../common/helper.dart';

class SearchView extends GetView<SearchController>{
  const SearchView({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              primary: true,
              children: const [
                Center(
                  child: Text("Tìm kiếm", style: TextStyle(color: Colors.blue, fontSize: 25),),
                ),
                NoDataPage()
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(AppConstants.version, style: const TextStyle(color: Colors.blue, fontSize: 16),),
              ),
            )
          ],
        ),
      ),
    );

  }

}