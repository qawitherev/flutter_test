import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udp/udp.dart';

class ListenBroadcastPage extends StatelessWidget {
  final ListenBroadcastController c = Get.put(ListenBroadcastController());

  ListenBroadcastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(c.appBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () {
            return c.isDisplayList.value
                ? ListView.builder(
                    itemCount: c.receivedData.length,
                    itemBuilder: (context, index) {
                      final theText = c.receivedData[index];
                      return ListTile(
                        title: Text(theText),
                      );
                    })
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        AcTile(),
                        const SizedBox(
                          height: 16,
                        ),
                        StatusTile(),
                      ],
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              c.isListening.value
                  ? const SizedBox.shrink()
                  : ElevatedButton(
                      onPressed: () => c.startListening(),
                      child: const Text('Start Listening')),
              const SizedBox(width: 16,),
              ElevatedButton(
                onPressed: () => c.toggleList(),
                child: c.isDisplayList.value
                    ? const Text('Show Tile')
                    : const Text('Show List'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class AcTile extends StatelessWidget {
  final ListenBroadcastController c = Get.put(ListenBroadcastController());
  static final boxSize = MediaQuery.of(Get.context!).size.width - 100;
  static const dataTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  AcTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        width: boxSize,
        height: boxSize,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Power'),
              Text(
                c.deviceState.value.power,
                style: dataTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Fan'),
              Text(
                c.deviceState.value.fan,
                style: dataTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Mode'),
              Text(
                c.deviceState.value.mode,
                style: dataTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Temperature'),
              Text(('${c.temperatureInt(c.deviceState.value.temperature)}'),
                  style: dataTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusTile extends StatelessWidget {
  final ListenBroadcastController c = Get.put(ListenBroadcastController());

  StatusTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: AcTile.boxSize,
      height: AcTile.boxSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Battery %'),
            const SizedBox(
              height: 10,
            ),
            Text(
              c.deviceStatus.value.batteryPercent.toString(),
              style: AcTile.dataTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Temperature'),
            Text(
              c.deviceStatus.value.temp.toStringAsFixed(1),
              style: AcTile.dataTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Device ID'),
            Text(
              c.deviceStatus.value.deviceId,
              style: AcTile.dataTextStyle,
            ),
          ],
        ),
      ),
    ));
  }
}

class ListenBroadcastController extends GetxController {
  final appBar = 'Listen Broadcast Page';
  Rx<bool> isListening = true.obs;
  bool isDeviceStatus = true;
  Rx<bool> isDisplayList = true.obs;
  static const portNumber = 59006;
  static const listeningDuration = Duration(minutes: 30);
  RxList<String> receivedData = RxList<String>();
  Rx<DeviceStatus> deviceStatus = DeviceStatus(
          batteryVolt: 0,
          batteryPercent: 0,
          temp: 0,
          humidity: 0,
          ip: '',
          deviceId: 'deviceId')
      .obs;
  Rx<DeviceState> deviceState = DeviceState(
          power: 'off',
          fan: 'off',
          mode: 'fan',
          hlouver: 'on',
          vlouver: 'on',
          temperature: '0',
          fid: 'temp+',
          ip: '0.0.0.0',
          deviceId: 'deviceId')
      .obs;

  @override
  void onInit() async {
    super.onInit();
    await startListening();
  }

  //listen to udp in given time
  Future<void> startListening() async {
    print('Listening started on port $portNumber');
    isListening.value = true;
    var receiver = await UDP.bind(Endpoint.any(port: const Port(portNumber)));
    receiver.asStream(timeout: listeningDuration).listen((datagram) {
      var str = String.fromCharCodes(datagram!.data);
      var map = jsonDecode(str) as Map<String, dynamic>;
      if (map.containsKey('power')) {
        deviceState.value = DeviceState.fromJson(map);
      } else if (map.containsKey('battery volt')) {
        deviceStatus.value = DeviceStatus.fromJson(map);
      }
      receivedData.add(str);
    });
    await Future.delayed(listeningDuration).then((value) => receiver.close());
    isListening.value = false;
    print('Listening finished');
  }

  void toggleList() => isDisplayList.value = !(isDisplayList.value);

  int temperatureInt(String temperatureString) {
    final decimalValue = double.parse(temperatureString);
    return decimalValue.toInt();
  }
}

class DeviceStatus {
  final int batteryVolt, batteryPercent;
  final double humidity;
  final num temp;
  final String ip, deviceId;

  DeviceStatus(
      {required this.batteryVolt,
      required this.batteryPercent,
      required this.temp,
      required this.humidity,
      required this.ip,
      required this.deviceId});

  factory DeviceStatus.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('battery volt')) {
      return DeviceStatus(
          batteryVolt: json['battery volt'],
          batteryPercent: json['battery percent'],
          temp: json['temperature'],
          humidity: json['humidity'],
          ip: json['ip'],
          deviceId: json['device_id']);
    } else {
      throw const FormatException('Invalid JSON format for device status');
    }
  }
}

class DeviceState {
  final String power,
      fan,
      mode,
      temperature,
      hlouver,
      vlouver,
      fid,
      ip,
      deviceId;

  DeviceState(
      {required this.power,
      required this.fan,
      required this.mode,
      required this.hlouver,
      required this.vlouver,
      required this.temperature,
      required this.fid,
      required this.ip,
      required this.deviceId});

  factory DeviceState.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('power')) {
      return DeviceState(
          power: json['power'],
          fan: json['fan'],
          mode: json['mode'],
          hlouver: json['hlouver'],
          vlouver: json['vlouver'],
          temperature: json['temperature'],
          fid: json['fid'],
          ip: json['ip'],
          deviceId: json['device_id']);
    } else {
      throw const FormatException('Invalid JSON format for device status');
    }
  }
}

/*
* udp responses
* state: -->
* 1. power,
* 2. fan,
* 3. mode,
* 4. hlouver,
* 5. vlouver,
* 6. temperature,
* 7. fid,
* 8. ip,
* 9. device_id
*
* status -->
* 1. battery volt,
* 2. battery percent,
* 3. temperature,
* 4. humidity,
* 5. ip,
* 6. device_id
*
* {"power":"off","fan":"high","mode":"fan","hlouver":"on","vlouver":"on","temperature":"25.0","fid":"temp+"}
* {"battery volt":5000,"battery percent":100,"temperature":24,"humidity":70.5,"ip":"192.168.0.152","device_id":"ADTIR-377AA4"}
* */
