import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VanillaIoTestPage extends StatelessWidget {
  final c = Get.put(VanillaIoTestController());

  VanillaIoTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(c.appBar),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => c.setupDatagram, child: const Text('UDP!')),
            const SizedBox(height: 10,),
            const Text('This is a test'),
            Text(
              c.message.value,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class VanillaIoTestController extends GetxController {
  final appBar = 'Vanilla I/O';
  final message = 'hello melaysia'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setupDatagram();
  }

  void setupDatagram() {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
      String data = 'Hello World';
      socket.broadcastEnabled = true;
      socket.send(data.codeUnits, InternetAddress('192.168.0.159'), 4444);
      socket.close();
    });
  }
}
