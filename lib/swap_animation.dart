import 'package:flutter/material.dart';

class SwapAnimation extends StatefulWidget {
  const SwapAnimation({Key? key}) : super(key: key);

  @override
  State<SwapAnimation> createState() => _SwapAnimationState();
}

class _SwapAnimationState extends State<SwapAnimation> {
  List<int> containerArrangement = [1,2,3,4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swap Animation'),),
      body: Row(
        children: [
          ElevatedButton(onPressed: () => _swapContainer(containerArrangement, 0, 1), child: const Text('Swap'),),
          Column(
            children: containerArrangement.map((containerId) {
              return MyContainer(id: containerId);
            }).toList(),
          ),
        ],
      )
    );
  }

  void _swapContainer(List<dynamic> theArray, int idx1, int idx2) {
    final temp = theArray[idx1];
    theArray[idx1] = theArray[idx2];
    theArray[idx2] = temp;
    print(theArray);
  }
}

class MyContainer extends StatelessWidget {
  final int id;
  const MyContainer({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('Container $id', style: const TextStyle(color: Colors.white),),),
    );
  }
}

