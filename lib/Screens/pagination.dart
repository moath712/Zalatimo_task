import 'package:flutter/material.dart';

class PaginationRow extends StatelessWidget {
  const PaginationRow({
    Key? key,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);

  final ValueNotifier<int> currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 15.0,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed:
              currentPage.value > 1 ? () => currentPage.value -= 1 : null,
        ),
        Visibility(
          visible: currentPage.value > 1,
          child: ElevatedButton(
            onPressed: () => currentPage.value = 1,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: const CircleBorder(),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(10),
            ),
            child: const Text(' 1'),
          ),
        ),
        const Text("....."),
        Visibility(
          visible: currentPage.value > 2,
          child: ElevatedButton(
            onPressed: () => currentPage.value -= 1,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: const CircleBorder(),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(10),
            ),
            child: Text(' ${currentPage.value - 1}'),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(10),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(' ${currentPage.value}'),
        ),
        Visibility(
          visible: currentPage.value < totalPages - 1,
          child: ElevatedButton(
            onPressed: () => currentPage.value += 1,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: const CircleBorder(),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(10),
            ),
            child: Text(' ${currentPage.value + 1}'),
          ),
        ),
        const Text("....."),
        Visibility(
          visible: currentPage.value < totalPages,
          child: ElevatedButton(
            onPressed: () => currentPage.value = totalPages,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: const CircleBorder(),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(10),
            ),
            child: Text(' $totalPages'),
          ),
        ),
        IconButton(
          iconSize: 15.0,
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: currentPage.value < totalPages
              ? () => currentPage.value += 1
              : null,
        )
      ],
    );
  }
}
