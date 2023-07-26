import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutTestingPage extends StatelessWidget {
  final c = Get.put(LayoutTestingController());

  LayoutTestingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(c.appBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Number 1'),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: c.numbers.length,
                itemBuilder: (context, index) {
                  final number = c.numbers[index];
                  return ListTile(
                    title: Text('$number'),
                  );
                },
              ),
            ),
            const Text('Number 2'),
            Flexible(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: c.numbers2.length,
                  itemBuilder: (context, index) {
                    final number = c.numbers2[index];
                    return ListTile(
                      title: Text('$number'),
                    );
                  }),
            ),
            const Text('Number 3'),
            Flexible(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: c.numbers2.length,
                  itemBuilder: (context, index) {
                    final number = c.numbers2[index];
                    return ListTile(
                      title: Text('$number'),
                    );
                  }),
            ),
            const Text('Number 4'),
            Flexible(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: c.numbers4.length,
                  itemBuilder: (context, index) {
                    final number = c.numbers4[index];
                    return ListTile(
                      title: Text('$number'),
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(maxLength: 10, decoration: InputDecoration(
                counterText: '',
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

class LayoutTestingController extends GetxController {
  final appBar = 'Layout Testing 🍆';
  List<int> numbers = List.generate(5, (index) => index + 1);
  List<int> numbers2 = List.generate(4, (index) => index + 1);
  List<int> numbers3 = List.generate(3, (index) => index + 1);
  List<int> numbers4 = List.generate(10, (index) => index + 1);
}
