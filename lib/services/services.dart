import 'dart:convert';
import 'dart:developer';

import 'package:convert_currenciy_mobile_app/constants/constants.dart';
import 'package:http/http.dart' as http;

class CurrencyServices {
  static Future<Map<String, dynamic>?> getAllCurrency() async {
    http.Response response;

    response = await http.get(Uri.parse(allCurrency));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> converteCurrency(String? value) async {
    http.Response response;

    response = await http.get(Uri.parse(
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$value.json"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
