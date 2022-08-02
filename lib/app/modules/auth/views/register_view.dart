import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/auth/controllers/register_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';

import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/text_field_widget.dart';

class RegisterView extends GetView<RegisterController>{
  const RegisterView( {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.registerFormKey = GlobalKey<FormState>();
   return Scaffold(
     backgroundColor: Colors.white,
     body: Form(
       key: controller.registerFormKey,
       child: Obx(
           (){
             if(controller.loading.value){
               return const Center(
                 child: CircularLoadingWidget(height: 300)
               );
             }  else {
               return ListView(
               primary: true,
               children: [
                 const SizedBox(height: 20,),
                 Image.asset("assets/icon/vientiem.png", height: 150,),
                 const SizedBox(height: 20,),
                 Center(
                   child: Text("Đăng kí".tr, style: const TextStyle(
                       color: Colors.black,
                       fontSize: 30,
                       fontWeight: FontWeight.bold),),
                 ),
                 const SizedBox(height: 20,),
                 // Text("Thông tin tài khoản".tr, style: const TextStyle(
                 //     color: Colors.black,
                 //     fontSize: 20,
                 //     fontWeight: FontWeight.bold)).marginOnly(left: 10),
                 TextFieldWidget(
                   labelText: "Họ và tên (*)".tr,
                   style: const TextStyle(
                       color: Colors.black,
                       fontSize: 17,
                   ),
                   labelStyle: const TextStyle(
                     color: Colors.black ,
                       fontSize: 18
                   ),
                   hintText: "Nguyễn Văn A",
                   initialValue: controller.registerRequest.value.fullName,
                   onSaved: (input) =>
                   controller.registerRequest.value.fullName = input,
                   validator: (input) =>
                   input.isEmpty
                       ? "Thông tin không được trống".tr
                       : null,
                 ),
                 TextFieldWidget(
                   labelStyle: const TextStyle(
                       color: Colors.black,
                     fontSize: 18
                   ),
                   labelText: "Số điện thoại".tr,
                   style: const TextStyle(
                       color: Colors.black,
                       fontSize: 17
                   ),
                   hintText: "0946137***",
                   onSaved: (input) =>
                   controller.registerRequest.value.phoneNumber = input,
                   initialValue: controller.registerRequest.value.phoneNumber,
                   validator: (input) =>
                   input.length < 10
                       ? "Số điện thoại không hợp lệ".tr
                       : null,
                 ),
                 TextFieldWidget(
                   labelStyle: const TextStyle(
                       color: Colors.black,
                       fontSize: 18
                   ),
                   labelText: "Mật khẩu".tr,
                   onSaved: (input) =>
                   controller.registerRequest.value.password = input,
                   initialValue: controller.registerRequest.value.password,
                   hintText: "******",
                   validator: (input) =>
                   input.length < 6
                       ? "Mật khẩu lớn hơn 6 kí tự".tr
                       : null,
                   obscureText: controller.hidePassword.value,
                   style: const TextStyle(
                       color: Colors.black,
                       fontSize: 17
                   ),
                   suffixIcon: IconButton(
                     onPressed: () {
                       controller.hidePassword.value =
                       !controller.hidePassword.value;
                     },
                     color: Theme
                         .of(context)
                         .focusColor,
                     icon: Icon(controller.hidePassword.value ? Icons
                         .visibility_outlined : Icons
                         .visibility_off_outlined, color: Colors.black),
                   ),
                 ),
                 TextFieldWidget(
                   labelStyle: const TextStyle(
                       color: Colors.black,
                       fontSize: 18
                   ),
                   labelText: "Nhập lại mật khẩu".tr,
                   style: const TextStyle(
                       color: Colors.black,
                       fontSize: 17
                   ),
                   obscureText: controller.hideCPassword.value,
                   initialValue: controller.registerRequest.value.confirmPass,
                   onSaved: (input) =>
                   controller.registerRequest.value.confirmPass = input,
                   hintText: "******",
                   validator: (input) =>
                   input.length < 6
                       ? "Mật khẩu lớn hơn 6 kí tự".tr
                       : null,
                   suffixIcon: IconButton(
                     onPressed: () {
                       controller.hideCPassword.value =
                       !controller.hideCPassword.value;
                     },
                     color: Theme
                         .of(context)
                         .focusColor,
                     icon: Icon(controller.hideCPassword.value ? Icons
                         .visibility_outlined : Icons
                         .visibility_off_outlined, color: Colors.black),
                   ),
                 ),
                 // Text("Thông tin chung".tr, style: const TextStyle(
                 //     color: Colors.black,
                 //     fontSize: 20,
                 //     fontWeight: FontWeight.bold)).marginOnly(left: 10),
                 // TextFieldWidget(
                 //   labelText: "Họ và tên (*)".tr,
                 //   hintText: "20/03/1999",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Thông tin không được trống".tr
                 //       : null,
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Ngày sinh".tr,
                 //   hintText: "20/03/1999",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Ngày sinh không được trống".tr
                 //       : null,
                 //   suffixIcon: IconButton(
                 //     onPressed: () {
                 //         controller.chooseBirthDate(context);
                 //     },
                 //     color: Theme
                 //         .of(context)
                 //         .focusColor,
                 //     icon: const Icon(Icons.date_range, color: Colors.black),
                 //   ),
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Giới tính".tr,
                 //   hintText: "",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Giới tính không được bỏ trống".tr
                 //       : null,
                 //
                 //   suffixIcon: IconButton(
                 //     onPressed: () {
                 //       // ignore: missing_return
                 //       showGenderSelectDialog(context, (val) {
                 //
                 //       });
                 //     },
                 //     color: Theme
                 //         .of(context)
                 //         .focusColor,
                 //     icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                 //   ),
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Mã bệnh nhân".tr,
                 //   hintText: "",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Thông tin không được bỏ trống".tr
                 //       : null,
                 //
                 // ),
                 // TextFieldWidget(
                 //   labelText: "CMND/CCCD".tr,
                 //   hintText: "",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Thông tin không được bỏ trống".tr
                 //       : null,
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Mã số BHYT".tr,
                 //   hintText: "",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Thông tin không được bỏ trống".tr
                 //       : null,
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Ngày tham gia".tr,
                 //   hintText: "15/6/2022",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Số điện thoại không hợp lệ".tr
                 //       : null,
                 //
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Email".tr,
                 //   hintText: "abc@gmail.com",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Số điện thoại không hợp lệ".tr
                 //       : null,
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Tỉnh/Thành Phố (*)".tr,
                 //   hintText: "Hồ Chí Minh",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Số điện thoại không hợp lệ".tr
                 //       : null,
                 //   suffixIcon: IconButton(
                 //     onPressed: () {
                 //       // ignore: missing_return
                 //       Provinces provinces = Get.arguments as Provinces;
                 //       controller.chooseProvince(provinces, context);
                 //     },
                 //     color: Theme
                 //         .of(context)
                 //         .focusColor,
                 //     icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                 //   ),
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Quận/Huyện (*)".tr,
                 //   hintText: "Quận 6",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Số điện thoại không hợp lệ".tr
                 //       : null,
                 //   suffixIcon: IconButton(
                 //     onPressed: () {
                 //       // ignore: missing_return
                 //       controller.chooseDistrict( context);
                 //     },
                 //     color: Theme
                 //         .of(context)
                 //         .focusColor,
                 //     icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                 //   ),
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Phường/Xã".tr,
                 //   hintText: "Phường 12",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Số điện thoại không hợp lệ".tr
                 //       : null,
                 //   suffixIcon: IconButton(
                 //     onPressed: () {
                 //       // ignore: missing_return
                 //       controller.chooseWard(context);
                 //     },
                 //     color: Theme
                 //         .of(context)
                 //         .focusColor,
                 //     icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                 //   ),
                 // ),
                 // TextFieldWidget(
                 //   labelText: "Số nhà/ Tên đường".tr,
                 //   hintText: "Số 115, đường Phạm Đinh Hổ",
                 //   validator: (input) =>
                 //   input.isEmpty
                 //       ? "Số điện thoại không hợp lệ".tr
                 //       : null,
                 // ),
                 BlockButtonWidget(
                   onPressed: () {
                     controller.register(context);
                   },
                   color: Get.theme.colorScheme.secondary,
                   text: Text(
                     "Đăng kí",
                     style: Get.textTheme.headline6.merge(
                         TextStyle(color: Get.theme.primaryColor)),
                   ),
                 ).paddingSymmetric(vertical: 10, horizontal: 20),
               ],
             );
             }
           }
       ),
     ),
   );
  }
  
}