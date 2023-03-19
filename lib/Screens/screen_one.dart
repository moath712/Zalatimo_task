import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_2/Colors/colors.dart';
import 'package:test_2/Providers/request.dart';
import 'package:test_2/Screens/pagination.dart';

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = useState(1);

    final productsAsyncValue = ref.watch(productsProvider(currentPage.value));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Zalatimo Sweets',
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Myriad Pro',
                color: MyColors.color2)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 48,
              width: 396,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search for an item',
                  hintStyle: TextStyle(
                    fontFamily: 'MyriadPro',
                    fontSize: 16.0,
                    color: MyColors.color2,
                  ),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
        ),
      ),
      body: productsAsyncValue.when(
        data: (data) {
          final products = data['products'];
          final totalPages = data['totalPages'];
          final currency = data['currency'];

          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(8.0),
                  children: List.generate(
                    products.length,
                    (index) {
                      final product = products[index];
                      return Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                            Text(
                              ' ${product.price.toStringAsFixed(2)} $currency ',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.normal,
                                  color: MyColors.color1),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Builder(builder: (context) {
                return PaginationRow(
                  currentPage: currentPage,
                  totalPages: totalPages,
                );
              }),
            ],
          );
        },
        loading: () => Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Center(
              child: Image.asset(
                'assets/Zalatimo_two.gif',
                width: 150,
                height: 150,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Builder(builder: (context) {
                    return PaginationRow(
                      currentPage: currentPage,
                      totalPages: 41,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}
