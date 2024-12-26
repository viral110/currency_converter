import 'dart:convert';
import 'dart:typed_data';

import 'package:convert_currenciy_mobile_app/constants/flag_json.dart';
import 'package:convert_currenciy_mobile_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString selectedValue1 = "usd".obs;
  RxString selectedValue2 = "inr".obs;

  RxDouble firstAmount = 0.0.obs;
  RxDouble secondAmount = 0.0.obs;

  final firstCountryController = TextEditingController(text: "1");
  final secoundCountryController = TextEditingController();

  Map<String, dynamic> dropdownItems = {};

  void getAllCurrency() async {
    var data = await CurrencyServices.getAllCurrency();

    if (data != null) {
      dropdownItems = data;
    }
    update();
  }

  void swapValue() {
    String temp = jsonEncode(selectedValue2.value);
    selectedValue2.value = selectedValue1.value;
    selectedValue1.value = jsonDecode(temp);
    currencyConvert();
  }

  currencyConvert() async {
    var currencyCoin =
        await CurrencyServices.converteCurrency(selectedValue1.value);
    dynamic firstValue =
        currencyCoin?[selectedValue1.value][selectedValue1.value];
    firstAmount.value = double.tryParse(firstValue.toString())!;
    firstCountryController.text = firstValue.toString();
    if (selectedValue2.value.isNotEmpty) {
      dynamic secondValue = currencyCoin?[selectedValue1.value][selectedValue2.value];
      secondAmount.value = double.tryParse(secondValue.toString())!;

      secoundCountryController.text = secondValue.toString();
    }
  }

  calculateFromTheCurrencyPrice() {
    double val = (double.tryParse(firstCountryController.text)! *
        double.tryParse(secondAmount.toString())!);

    secoundCountryController.text = val.toString();

    update();
  }

  calculateToTheCurrencyPrice() {
    double val = (double.tryParse(firstAmount.toString())! /
        double.tryParse(secoundCountryController.text)!);

    firstCountryController.text = val.toString();

    update();
  }

  @override
  void onInit() {
    getAllCurrency();
    currencyConvert();
    super.onInit();
  }

  Map<String, String> convaertMap() {
    Map<String, String> ListMap = {};

    flagMap.forEach(
      (element) {
        ListMap[element["code"] ?? ""] = element["flag"] ?? "";
      },
    );

    return ListMap;
  }

  Uint8List convertImage(String? image) {
    return base64Decode(image?.replaceAll("data:image/png;base64,", "") ?? "");
  }
}
