import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTestPage extends StatelessWidget {
  final ListTestController c = Get.put(ListTestController());

  ListTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Test Page'),),
      body: Column(
        children: List.generate(4, (index) {
          final containerItem = c.containerItems[index];
          return GestureDetector(onTap: () {
            c.selectContainer(index);
          },
            child: Obx(() {
              final selected = containerItem.selected.value;
              return Container(
                width: 100,
                height: 100,
                color: selected ? Colors.blue : Colors.grey,
              );
            }),
          );
        },),
      ),
    );
  }
}

class ContainerItem {
  final RxBool selected;

  ContainerItem({bool isSelected = false}) : selected = isSelected.obs;
}

class ListTestController extends GetxController {
  final List<ContainerItem> containerItems = List.generate(
      4, (index) => ContainerItem());

  void selectContainer(int index) {
    for (int i = 0; i < containerItems.length; i++) {
      containerItems[i].selected.value = (i == index);
    }
  }
}
