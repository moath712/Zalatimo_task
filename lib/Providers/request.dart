import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_2/model.dart';

final productsProvider = FutureProvider.family((ref, int page) async {
  final response = await http.get(Uri.parse(
      'https://zalatimoprod.rhinosoft.io/api/products?maxPrice=1000&minPrice=0&modes=ALL&page=$page&pageSize=10'));
  final json = jsonDecode(response.body);
  final productsJson = json['data'];
  final products = productsJson.map((json) => Product.fromJson(json)).toList();
  final count = json['count'] as int;
  final currency = json['currency'];
  final totalPages = (count / 10).ceil();

  return {
    'products': products,
    'totalPages': totalPages,
    'currency': currency,
  };
});
