import 'dart:io';

import 'package:flutter/material.dart';
import 'package:udp/udp.dart';

class UdpTestingPage extends StatefulWidget {
  const UdpTestingPage({Key? key}) : super(key: key);

  @override
  State<UdpTestingPage> createState() => _UdpTestingPageState();
}

class _UdpTestingPageState extends State<UdpTestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UDP Testing Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async => await MyUdpListener.startListening(),
                  child: const Text('Start listening'))
            ],
          ),
        ));
  }
}

class MyUdpListener {
  static Future<void> startListening() async {
    bool isListening = false;
    await Future.delayed(const Duration(seconds: 3));
    isListening = true;
    print('start listening...');
    var receiver = await UDP.bind(Endpoint.any(port: const Port(59006)));
    receiver.asStream(timeout: const Duration(minutes: 1)).listen((datagram) {
      var str = String.fromCharCodes(datagram!.data);
      print(str);
    });
    await Future.delayed(const Duration(minutes: 1)).then((value) {
      print('listening finished');
      receiver.close();
      isListening = false;
    });
  }
}


