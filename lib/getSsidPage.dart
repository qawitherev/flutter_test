import 'package:flutter/material.dart';
// import 'package:wifi_iot/wifi_iot.dart';

class GetSsidPage extends StatelessWidget {
  const GetSsidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text('Get Wifi SSID'),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () async {
            // final ssid = await WiFiForIoTPlugin.getSSID() ?? '';
            // print('wifi ssid is $ssid');
          }, child: const Text('Get Wifi SSID'))
        ],
      ),)
    );
  }
}
