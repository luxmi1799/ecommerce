import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/bloc/ecommerce/ecommerce_model.dart';
import 'package:http/http.dart' as http;

class EcommerceRepository {
  Future<List<Products>> getProducts() async {
    try {
      List<Products> model = [];
      //List<Products> movies = [];
      final url =
          'http://209.182.213.242/~mobile/MtProject/public/api/product_list.php';
      String token =
          "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz";

      var res = await http.post(Uri.parse(url), headers: {
        // "Accept": "application/json",
        // "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': 'Bearer $token',
      }, body: {
        "page": "1",
        "perPage": "5",
      });
      var bodyIs = res.body;
      var statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        debugPrint("bodyIs $bodyIs $map");
        model =
            List<Products>.from(map['data'].map((x) => Products.fromJson(x)));
        return model;
      } else {}

      return model;
      // return movies;
    } catch (e) {
      throw e;
    }
  }
}
