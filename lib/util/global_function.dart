import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../config/constants.dart';

class GlobalFunction {
  // 포커스 해제 함수
  static void unFocus() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  // 다이얼로그
  static Future<void> showCustomDialog({
    Widget? child,
    String title = '',
    String description = '',
    String okText = '확인',
    String cancelText = '취소',
    bool showCancelBtn = false,
    GestureTapCallback? okFunc,
    GestureTapCallback? cancelFunc,
    bool barrierDismissible = true,
  }) {
    // 버튼
    Widget button(
        {required String text,
        required GestureTapCallback onTap,
        required Color bgColor,
        required Color borderColor,
        required Color fontColor}) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular($style.corners.$12),
          child: Container(
            width: double.infinity,
            height: 48 * sizeUnit,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular($style.corners.$12),
              border: Border.all(color: borderColor, width: 1 * sizeUnit),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: $style.text.subTitle16.copyWith(color: fontColor),
            ),
          ),
        ),
      );
    }

    return Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: $style.insets.$40),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular($style.corners.$12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24 * sizeUnit),
                if(title.isNotEmpty) Text(title, style: $style.text.subTitle16),
                if (child != null) ...[
                  child,
                ] else ...[
                  if (description.isNotEmpty) ...[
                    SizedBox(height: 12 * sizeUnit),
                    Text(
                      description,
                      style: $style.text.body14,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
                SizedBox(height: 24 * sizeUnit),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * sizeUnit),
                  child: Row(
                    children: [
                      if (showCancelBtn) ...[
                        Expanded(
                          child: button(
                            text: cancelText,
                            bgColor: Colors.white,
                            borderColor: $style.colors.primary,
                            fontColor: $style.colors.primary,
                            onTap: cancelFunc ?? () => Get.back(),
                          ),
                        ),
                        SizedBox(width: 8 * sizeUnit),
                      ],
                      Expanded(
                        child: button(
                          text: okText,
                          bgColor: $style.colors.primary,
                          borderColor: $style.colors.primary,
                          fontColor: Colors.white,
                          onTap: okFunc ?? () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16 * sizeUnit),
              ],
            ),
          ),
        ),
      ),
      barrierColor: $style.colors.barrierColor,
      barrierDismissible: barrierDismissible,
    );
  }

  // 토스트
  static void showToast({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: $style.colors.primary,
      textColor: Colors.white,
    );
  }

  // 로그인
  static Future<void> globalLogin({required String email, required Function nullCallback}) async {

  }

  // 로그아웃
  static Future<void> logout() async{

  }

  // date picker
  static Future<DateTime> datePicker({required BuildContext context, DateTime? initialDateTime, DateTime? minimumDateTime}) async {
    unFocus(); // 포커스 해제

    final DateTime now = DateTime.now();
    final DateTime initDateTime = initialDateTime ?? now;
    DateTime? date;

    await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 200 * sizeUnit,
          width: double.infinity,
          color: Colors.white,
          child: CupertinoDatePicker(
            backgroundColor: Colors.white,
            initialDateTime: initDateTime,
            mode: CupertinoDatePickerMode.date,
            minimumDate: minimumDateTime,
            maximumYear: now.year,
            onDateTimeChanged: (val) => date = val,
          ),
        ));

    date ??= initDateTime;
    return DateTime(date!.year, date!.month, date!.day, 12);
  }

  // 실명 유효성 검사
  static String? validRealNameErrorText(String name) {
    String? errMsg;

    RegExp regExp = RegExp(r'(^[가-힣]{2,10}$)'); // 2 ~ 10개 한글 입력가능
    if (!regExp.hasMatch(name)) errMsg = '이름을 정확히 입력해 주세요.';
    return errMsg;
  }

  // 핸드폰 유효성 검사
  static String? validPhoneNumErrorText(String number) {
    String? errMsg;

    RegExp regExp = RegExp(r'^\d{10,11}$'); // 10 ~ 11개 숫자 입력가능
    if (!regExp.hasMatch(number)) errMsg = '휴대폰 번호를 정확히 입력해 주세요.';
    return errMsg;
  }

  // 로딩 다이어로그
  static void loadingDialog() {
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(color: $style.colors.primary),
        ),
      ),
    );
  }
}
