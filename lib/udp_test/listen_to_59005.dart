import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udp/udp.dart';

class ListenTo59005Page extends StatelessWidget {
  final ListenTo59005Controller c = Get.put(ListenTo59005Controller());

  ListenTo59005Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(c.appbar),),
      body: Column(
        children: [
          ElevatedButton(onPressed: () => c.startUdp(), child: const Text('hehe')),
          Center(
            child: Obx(() {
              return Text(c._message.value);
            }),
          ),
        ],
      ),
    );
  }
}

class ListenTo59005Controller extends GetxController {
  final appbar = 'Listen to 59005';
  final _message = 'hello malaysia'.obs;

  @override
  void onInit() {
    super.onInit();
    startUdp();
  }

  Future<void> startUdp() async {
    print('this here');
    var sender = await UDP.bind(Endpoint.any(port: const Port(65000)));

    // send a simple string to a broadcast endpoint on port 65001.
    await sender.send(
        '::REQUEST-ADT-IOT-DEVICE-INFO:;'.codeUnits, Endpoint.broadcast(port: Port(59005)));
    sender.close();

    var receiver = await UDP.bind(Endpoint.any(port: const Port(59005)));
    receiver.asStream().listen((event) {
      var str = String.fromCharCodes(event!.data);
      _message.value = str;
    });
  }
}
