import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/account/controllers/account_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/common/ui.dart';
import '../../../../common/size_config.dart';
import '../../../models/provice.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/dialog/gender_select_dialog.dart';
import '../../global_widgets/text_field_widget.dart';

class UserInfoView extends GetView<AccountController> {
  const UserInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.profile.value.fullname ==
        controller.profile.value.username) {
      controller.profile.value.fullname =
          controller.userInfo.value.data.userInfo.fullName;
      controller.bgUploadProfile(context);
    }
    return BasePage(
      title: "Thông tin cá nhân",
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.9,
        child: Obx(() {
          return Form(
            key: controller.infoFormKey,
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  primary: true,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      labelText: "Họ và tên".tr,
                      hintText: "",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      onSaved: (s) => controller.profile.value.fullname = s,
                      initialValue: controller.profile.value.fullname ==
                              controller.profile.value.username
                          ? controller.userInfo.value.data.userInfo.fullName
                          : controller.profile.value.fullname,
                    ),
                    TextFieldWidget(
                      keyboardType: TextInputType.none,
                      labelText: "Giới tính".tr,
                      hintText: "",
                      initialValue: "",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      controller: controller.genderEdt,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      validator: (input) => input.isEmpty
                          ? "Giới tính không được bỏ trống".tr
                          : null,
                      suffixIcon: IconButton(
                        onPressed: () {
                          // ignore: missing_return
                          showGenderSelectDialog(context, (val) {
                            controller.genderEdt.text = val == 1 ? "Nam" : "Nữ";
                            controller.profile.value.gender =
                                val == 1 ? true : false;
                          });
                        },
                        color: Theme.of(context).focusColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFieldWidget(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      labelText: "Ngày sinh".tr,
                      keyboardType: TextInputType.none,
                      controller: controller.dobEdt,
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.chooseBirthDate(context);
                        },
                        color: Theme.of(context).focusColor,
                        icon: const Icon(Icons.date_range, color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.showSnackbar(Ui.RemindSnackBar(
                            message: "Không thể thay đổi số điện thoại"));
                      },
                      child: TextFieldWidget(
                        keyboardType: TextInputType.number,
                        labelText: "Điện thoại".tr,
                        isEdit: false,
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        hintText: "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        initialValue:
                            controller.profile.value.phoneNumber.isEmpty
                                ? controller
                                    .userInfo.value.data.userInfo.phoneNumber
                                : controller.profile.value.phoneNumber,
                        onSaved: (input) =>
                            controller.profile.value.phoneNumber = input,
                      ),
                    ),
                    TextFieldWidget(
                      labelText: "CMND/CCCD".tr,
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      keyboardType: TextInputType.number,
                      hintText: "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      initialValue: controller.profile.value.identityCard,
                      onSaved: (input) =>
                          controller.profile.value.identityCard = input,
                    ),
                    TextFieldWidget(
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      labelText: "Mã số BHYT".tr,
                      hintText: "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      initialValue: controller.profile.value.insurranceCode,
                      onSaved: (input) =>
                          controller.profile.value.insurranceCode = input,
                    ),
                    // TextFieldWidget(
                    //   labelText: "Ngày tham gia".tr,
                    //   style: const TextStyle(color: Colors.black),
                    // ),
                    TextFieldWidget(
                      labelText: "Email".tr,
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      initialValue: controller.profile.value.email,
                      onSaved: (input) =>
                          controller.profile.value.email = input,
                    ),
                    TextFieldWidget(
                      // isEdit: false,
                      keyboardType: TextInputType.none,
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      labelText: "Tỉnh/Thành Phố (*)".tr,
                      controller: controller.proviceEdt,
                      suffixIcon: IconButton(
                        onPressed: () {
                          // ignore: missing_return
                          Provinces provinces = Get.arguments as Provinces;
                          controller.chooseProvince(provinces, context);
                        },
                        color: Theme.of(context).focusColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFieldWidget(
                      labelText: "Quận/Huyện".tr,
                      keyboardType: TextInputType.none,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      controller: controller.districtEdt,
                      suffixIcon: IconButton(
                        onPressed: () {
                          // ignore: missing_return
                          controller.chooseDistrict(context);
                        },
                        color: Theme.of(context).focusColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFieldWidget(
                      keyboardType: TextInputType.none,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      labelText: "Phường/Xã".tr,
                      controller: controller.wardEdt,
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      suffixIcon: IconButton(
                        onPressed: () {
                          // ignore: missing_return
                          controller.chooseWard(context);
                        },
                        color: Theme.of(context).focusColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFieldWidget(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      labelText: "Số nhà/ Tên đường".tr,
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      initialValue: controller.profile.value.address,
                      onSaved: (input) =>
                          controller.profile.value.address = input,
                    ),
                    BlockButtonWidget(
                      onPressed: () {
                        controller.uploadProfile(context);
                      },
                      color: Get.theme.colorScheme.secondary,
                      text: Text(
                        "Cập nhật",
                        style: Get.textTheme.headline6
                            .merge(TextStyle(color: Get.theme.primaryColor)),
                      ),
                    ).paddingSymmetric(vertical: 10, horizontal: 20),
                  ],
                )),
          );
        }),
      ),
    );
  }

  Widget horiFunc(String icon, String title, {Function ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.01,
                ),
                Image.asset(icon,
                    height: SizeConfig.screenWidth * 0.11,
                    width: SizeConfig.screenWidth * 0.09),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.04,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.screenWidth * 0.045,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: SizeConfig.screenWidth * 0.04,
              color: Colors.black.withOpacity(0.7),
            )
          ],
        ),
      ),
    );
  }
}
