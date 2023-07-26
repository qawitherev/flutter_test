import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_encrypt/bonsoir_test/bonsoir_1_page.dart';
import 'package:qr_encrypt/bonsoir_test/vanilla_io_test.dart';
import 'package:qr_encrypt/layout_testing/column_draggable.dart';
import 'package:qr_encrypt/layout_testing/layout_testing.dart';
import 'package:qr_encrypt/udp_test/udp_broadcast_test.dart';
import 'package:workmanager/workmanager.dart';

import 'widget_testing/widget_testing.dart';

const printTask = 'com.example.printTask';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testing Project',
      home: ColumnDraggablePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Workmanager().registerOneOffTask(printTask, printTask, initialDelay: const Duration(seconds: 10),
              inputData: <String, dynamic>{
                'key1': 'value1',
                'key2': 'value2',
                'key3': 'value3',
              });
            }, child: const Text('Task Print'),),
          ],
        ),
      ),
    );
  }
}


// *************************************************

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case printTask:
        print('Hello world with data ---> $inputData');
        break;
    }
    return Future.value(true);
  });
}



