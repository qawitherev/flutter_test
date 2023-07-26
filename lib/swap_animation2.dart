import 'package:flutter/material.dart';

class SwapAnimation2 extends StatelessWidget {
  const SwapAnimation2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swap Animation II'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Draggable(
                data: 10,
                feedback: Opacity(
                  opacity: .5,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: const Icon(Icons.play_circle_rounded),
                  ),
                ),
                childWhenDragging: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: const Text(
                    'When Dragging',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: const Text(
                    'Child',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              DragTarget(
                builder: (BuildContext context, List<Object?> candidateData,
                    List<dynamic> rejectedData) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueAccent,
                    child: const Text(
                      'DragTarget',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
                onAccept: (int data) {
                  print('dragTarget.onAccept()');
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Draggable(
                data: 'container1',
                childWhenDragging: Container(width: 100, height: 100, color: Colors.transparent,),
                feedback: Opacity(
                  opacity: .5,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                ),
                child: DragTarget(builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                  return Container(width: 100, height: 100, color: Colors.blue,);
                },),
              ),
              const SizedBox(width: 20,),
              Draggable(
                data: 'container2',
                childWhenDragging: Container(width: 100, height: 100, color: Colors.transparent,),
                feedback: Opacity(
                  opacity: .5,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                ),
                child: DragTarget(builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                  return Container(width: 100, height: 100, color: Colors.red,);
                },),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
