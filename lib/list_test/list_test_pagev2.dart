import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTestPageV2 extends StatelessWidget {
  final ListTestV2Controller c = Get.put(ListTestV2Controller());

  ListTestPageV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ListTestV2Controller.appbar),
      ),
      body: ListView.builder(
          itemCount: c.radioContainer.length, itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            final isSelected = index == c.selectedIndex.value;
            return GestureDetector(
              onTap: () => c.selectContainer(index),
              child: Container(
                color: isSelected ? Colors.blue : Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(c.radioContainer[index].data),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}

class RadioContainer {
  final String data;

  RadioContainer({required this.data});
}


class ListTestV2Controller extends GetxController {
  List<RadioContainer> get radioContainer =>
      [
        RadioContainer(data: 'data1'),
        RadioContainer(data: 'data2'),
        RadioContainer(data: 'data3'),
        RadioContainer(data: 'data4'),
        RadioContainer(data: 'data5'),
        RadioContainer(data: 'data6'),
      ];

  static const appbar = 'Container Radio Check';
  Rx<int> selectedIndex = (-1).obs;

  void selectContainer(index) {
    selectedIndex.value = index;
  }
}
