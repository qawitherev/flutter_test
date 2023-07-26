import 'package:bonsoir/bonsoir.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bonsoir1Page extends StatelessWidget {
  final Bonsoir1Controller c = Get.put(Bonsoir1Controller());

  Bonsoir1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(c.appBar),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => c.bonsoirBroadcast(),
              child: const Text('Start broadcast'),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () => c.bonsoirDiscovery(),
              child: const Text('Start Discovery'),),
            const SizedBox(height: 10,),
            Obx(() {
              return Text('Found service name is ${c.foundService.value}');
            }),
            const SizedBox(height: 10,),
            Obx(() {
              return Text(c.serviceStatus.value);
            }),
            Obx(() {
              return Text(c.discoveryStatus.value);
            }),
          ],
        ),
      ),
    );
  }
}

class Bonsoir1Controller extends GetxController {
  final appBar = 'Bonsoir1';
  final foundService = ''.obs;
  final serviceStatus = ''.obs;
  final discoveryStatus = ''.obs;
  static const serviceType = '_wonderful-service._udp';
  static const portNum = 4444;

  @override
  void onInit() {
    super.onInit();
    bonsoirBroadcast();
  }

  void startBoth() {
    bonsoirBroadcast();
    bonsoirDiscovery();
  }

  void bonsoirBroadcast() async {
    const Map<String, String> serviceAttr = {
      'key': '::REQUEST-ADT-IOT-DEVICE-INFO:;'
    };
    BonsoirService myService = const BonsoirService(
        name: 'myServiceFromIphone',
        type: serviceType,
        port: portNum,
        attributes: serviceAttr);
    BonsoirBroadcast broadcast = BonsoirBroadcast(service: myService);
    await broadcast.ready;
    await broadcast.start();
    serviceStatus.value = 'Service Started';

    await Future.delayed(const Duration(minutes: 1));
    await broadcast.stop();
    serviceStatus.value = 'Service Stopped';
  }

  void bonsoirDiscovery() async {
    BonsoirDiscovery discoveryChannel = BonsoirDiscovery(type: serviceType);
    await discoveryChannel.ready;
    discoveryStatus.value = 'Discovery started';

    discoveryChannel.eventStream?.listen((event) {
      if (event.type == BonsoirDiscoveryEventType.discoveryServiceResolved) {
        print('Service has been found: ${event.service?.toJson()}');
        foundService.value = event.service!.name;
      } else if (event.type == BonsoirDiscoveryEventType.discoveryServiceLost) {
        print('Service has been lost: ${event.service?.toJson()}');
      }
    });

    await discoveryChannel.start();

    await Future.delayed(const Duration(minutes: 1));

    await discoveryChannel.stop();
    discoveryStatus.value = 'Discovery stopped';
  }

}
