import 'package:flutter/material.dart';

class SwapContainers extends StatefulWidget {
  const SwapContainers({Key? key}) : super(key: key);

  @override
  State<SwapContainers> createState() => _SwapContainersState();
}

class _SwapContainersState extends State<SwapContainers> {
  List<ContainerData> containers = [
    ContainerData(key: 'container1', color: Colors.red),
    ContainerData(key: 'container2', color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swap 2 Containers'),
      ),
      body: Center(
        child: Column(
          children: containers.map((container) {
            int index = containers.indexOf(container);
            return GestureDetector(
              onTap: () {
                setState(() {
                  //swap containers
                  ContainerData temp = containers[0];
                  containers[0] = containers[1];
                  containers[1] = temp;
                });
              },
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, index == 0 ? 0 : 1),
                  end: Offset(0, index == 0 ? 1 : 0),
                ).animate(CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeInOut)),
                child: Container(
                  key: ValueKey(container.key),
                  width: 150,
                  height: 150,
                  color: container.color,
                  child: Text(container.key, style: const TextStyle(color: Colors.white),),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ContainerData {
  final String key;
  final Color color;

  ContainerData({required this.key, required this.color});
}
