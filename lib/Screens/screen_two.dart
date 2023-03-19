import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_2/Colors/colors.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final List<Product2> _products = [];
  int _currentPage = 1;
  bool _isLoading = true;

  Future<void> _fetchProducts() async {
    final url =
        'https://zalatimoprod.rhinosoft.io/api/products?maxPrice=1000&minPrice=0&modes=ALL&page=$_currentPage&pageSize=10';
    final response = await http.get(Uri.parse(url));
    final List<dynamic> data = json.decode(response.body)['data'];
    final List<Product2> products =
        data.map((product) => Product2.fromJson(product)).toList();
    setState(() {
      _isLoading = false;
      _products.addAll(products);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: Stack(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == _products.length - 1) {
                  _currentPage++;
                  _fetchProducts();
                }
                final product = _products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Positioned(
                          top: 10.0,
                          right: 10.0,
                          child: GestureDetector(
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.favorite_border,
                                color: MyColors.color3,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          product.mediaUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.normal,
                                  color: MyColors.color2),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' ${product.price.toStringAsFixed(2)} JOD',
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'MyriadPro',
                            fontWeight: FontWeight.normal,
                            color: MyColors.color1),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _products.length,
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

class Product2 {
  final String name;
  final String mediaUrl;
  final double price;
  String? currency;
  Product2(
      {required this.name,
      required this.mediaUrl,
      required this.price,
      this.currency});

  factory Product2.fromJson(Map<String, dynamic> json) {
    return Product2(
      name: json['name'],
      mediaUrl: json['mediaUrl'],
      price: json['price'].toDouble(),
      currency: json['currency'],
    );
  }
}
