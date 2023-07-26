import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetTestingPage extends StatelessWidget {
  final c = Get.put(WidgetTestingController());

  WidgetTestingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const verSpace = SizedBox(
      height: 10,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(c.appbar),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              enabled: c.isEnable.value,
              maxLength: 50,
              controller: c.tfController,
              onChanged: (input) => c.limitLength(input),
            ),
            verSpace,
            ElevatedButton(
                onPressed: () => c.getLength(),
                child: const Text('Get Length')),
            Obx(() {
              return Text(
                c.textLength.value,
                textAlign: TextAlign.center,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class WidgetTestingController extends GetxController {
  final limitCharacter = 50;
  final appbar = 'Widget Testing Controller';
  final tfController = TextEditingController();
  final textLength = ''.obs;
  final isEnable = true.obs;

  void getLength() {
    textLength.value = tfController.text.length.toString();
  }

  void limitLength(String input) {
    final actualLength = tfController.text.length;
    if (actualLength > limitCharacter) {
      textLength.value = tfController.text.substring(0, limitCharacter);
      tfController.value = TextEditingValue(
          text: tfController.text.substring(0, limitCharacter),
          selection: TextSelection.collapsed(offset: limitCharacter));
    }
  }
}
