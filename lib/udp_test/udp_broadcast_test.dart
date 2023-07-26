import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udp/udp.dart';

class UdpBroadcastPage extends StatelessWidget {
  final c = Get.put(UdpBroadcastController());

  UdpBroadcastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const verSpace = SizedBox(height: 10);

    return Scaffold(
      appBar: AppBar(
        title: Text(c.appBar),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text('Unicast Section'),
                    verSpace,
                    Obx(() {
                      return ElevatedButton(
                          onPressed: () => c.udpUnicast(),
                          child: c.isUnicast.value
                              ? const Text('Stop')
                              : const Text('Start'));
                    }),
                    verSpace,
                    Obx(() {
                      return Text(c.unicastResp.value, textAlign: TextAlign.center);
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Broadcast Section'),
                      verSpace,
                      Obx(() {
                        return ElevatedButton(onPressed: () => c.broadcast(),
                            child: c.isBroadcast.value
                                ? const Text('Stop')
                                : const Text('Start'));
                      }),
                      verSpace,
                      Obx(() {
                        return Text(c.broadcastResp.value, textAlign: TextAlign.center,);
                      }),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class UdpBroadcastController extends GetxController {
  final appBar = 'UDP Broadcast Page';
  final unicastResp = 'resp'.obs;
  final broadcastResp = 'resp'.obs;
  final sendPort = const Port(9999);
  final receivePort = const Port(4444);
  final realReceivePort = const Port(59005);
  final message = '::REQUEST-ADT-IOT-DEVICE-INFO:;';
  final aliveDuration = const Duration(seconds: 30);
  final isUnicast = false.obs;
  final isBroadcast = false.obs;

  @override
  void onInit() {
    udpUnicast();
    super.onInit();
  }

  //**************UNICAST WORKS ON IOS BUT NEED 1-1 CONNECTION WITH DEVICE*****************//
  void udpUnicast() async {
    isUnicast.value = true;
    var sender = await UDP.bind(Endpoint.any(port: sendPort));
    var data = await sender.send(
        message.codeUnits,
        Endpoint.unicast(InternetAddress('192.168.1.1'),
            port: const Port(59005)));
    print('$data bytes sent');
    sender.asStream().listen((datagram) {
      var str = String.fromCharCodes(datagram!.data).trim();
      print('datagram received is $str');
      unicastResp.value = str;
    });
    await Future.delayed(aliveDuration);
    sender.close();
    isUnicast.value = true;
  }

  void broadcast() async {
    isBroadcast.value = true;
    var sender = await UDP.bind(Endpoint.any(port: sendPort));
    var data = await sender.send(
        message.codeUnits, Endpoint.broadcast(port: realReceivePort));
    print('$data byte send');
    sender.asStream().listen((datagram) async {
      var str = String.fromCharCodes(datagram!.data).trim();
      print('datagram received is $str');
      broadcastResp.value = str;
    });
    await Future.delayed(aliveDuration);
    sender.close();
    isBroadcast.value = false;
  }
}
