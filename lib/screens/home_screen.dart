import 'dart:developer';

import 'package:convert_currenciy_mobile_app/constants/colors_helper.dart';
import 'package:convert_currenciy_mobile_app/constants/flag_json.dart';
import 'package:convert_currenciy_mobile_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: GetBuilder<HomeController>(builder: (context) {
            return Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Currency Converter",
                    style: TextStyle(
                        color: ColorsHelper.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Check live rates, set rate alerts, receive\nnotifications and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorsHelper.lightTextColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Amount",
                          style: TextStyle(
                            color: ColorsHelper.lightTextColor,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 15),
                        Obx(
                          () => Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: controller
                                                  .convertImage(
                                                    controller.convaertMap()[
                                                        controller
                                                            .selectedValue1
                                                            ?.toUpperCase()],
                                                  )
                                                  .isEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(18),
                                                  child: Image.asset(
                                                    "assets/not-found.png",
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.memory(
                                                    fit: BoxFit.cover,
                                                    height: 50,
                                                    controller.convertImage(
                                                      controller.convaertMap()[
                                                          controller
                                                              .selectedValue1
                                                              ?.toUpperCase()],
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      DropdownButton<String>(
                                        value: controller.selectedValue1.value,
                                        iconSize: 30,
                                        items: controller.dropdownItems.entries
                                            .map(
                                          (e) {
                                            // String key =e.key;
                                            // debugPrint(e.key.toString());

                                            return DropdownMenuItem<String>(
                                              value: e.key,
                                              child: Text(
                                                e.key.toUpperCase(),
                                                style: TextStyle(
                                                    color: ColorsHelper
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            controller.selectedValue1.value =
                                                newValue!;
                                            if (controller.selectedValue1 !=
                                                    "" &&
                                                controller.selectedValue2 !=
                                                    "") {
                                              controller.currencyConvert();
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey,
                                        ),
                                        underline: SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    controller:
                                        controller.firstCountryController,
                                    onChanged: (value) {
                                      controller
                                          .calculateFromTheCurrencyPrice();
                                    },
                                    decoration: InputDecoration(
                                      fillColor: ColorsHelper.textBoxColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                controller.swapValue();
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: ColorsHelper.primaryColor,
                                child: SvgPicture.asset(
                                  "assets/group.svg",
                                  height: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Converted Amount",
                          style: TextStyle(
                            color: ColorsHelper.lightTextColor,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 15),
                        Obx(
                          () => Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: controller
                                                  .convertImage(
                                                    controller.convaertMap()[
                                                        controller
                                                            .selectedValue2
                                                            ?.toUpperCase()],
                                                  )
                                                  .isEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(18),
                                                  child: Image.asset(
                                                    "assets/not-found.png",
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.memory(
                                                    fit: BoxFit.cover,
                                                    controller.convertImage(
                                                      controller.convaertMap()[
                                                          controller
                                                              .selectedValue2
                                                              ?.toUpperCase()],
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      DropdownButton<String>(
                                        value: controller.selectedValue2.value,
                                        iconSize: 30,
                                        padding: EdgeInsets.zero,
                                        items: controller.dropdownItems.entries
                                            .map(
                                          (e) {
                                            // String key =e.key;
                                            // debugPrint(e.key.toString());

                                            return DropdownMenuItem<String>(
                                              value: e.key,
                                              child: Text(
                                                e.key.toUpperCase(),
                                                style: TextStyle(
                                                    color: ColorsHelper
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            controller.selectedValue2.value =
                                                newValue!;

                                            controller.currencyConvert();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey,
                                        ),
                                        underline: SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    controller:
                                        controller.secoundCountryController,
                                    onChanged: (value) {
                                      controller.calculateToTheCurrencyPrice();
                                    },
                                    decoration: InputDecoration(
                                      fillColor: ColorsHelper.textBoxColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Indicative Exchange Rate",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "1 ${controller.selectedValue1.toUpperCase()} = ${controller.secondAmount.value.toStringAsFixed(2)} ${controller.selectedValue2.toUpperCase()}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
