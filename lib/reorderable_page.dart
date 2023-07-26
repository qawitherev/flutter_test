import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ReorderablesPage extends StatefulWidget {
  const ReorderablesPage({Key? key}) : super(key: key);

  @override
  State<ReorderablesPage> createState() => _ReorderablesPageState();
}

class _ReorderablesPageState extends State<ReorderablesPage> {
  final double iconSize = 90;
  late List<Widget> tiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tiles = [
      // Icon(Icons.filter_1, size: iconSize),
      // Icon(Icons.filter_2, size: iconSize),
      // Icon(Icons.filter_3, size: iconSize),
      // Icon(Icons.filter_4, size: iconSize),
      // Icon(Icons.filter_5, size: iconSize),
      // Icon(Icons.filter_6, size: iconSize),
      // Icon(Icons.filter_7, size: iconSize),
      // Icon(Icons.filter_8, size: iconSize),
      // Icon(Icons.filter_9, size: iconSize),
      Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Text(
          '1',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Text(
          '2',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Text(
          '3',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Text(
          '4',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Text(
          '5',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 100,
        color: Colors.blue,
        child: const Text(
          '6',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 100,
        color: Colors.blueGrey,
        child: const Text(
          '7',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 100,
        color: Colors.pinkAccent,
        child: const Text(
          '8',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 100,
        color: Colors.pinkAccent,
        child: const Text(
          '8',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      Container(
        width: 200,
        height: 100,
        color: Colors.pinkAccent,
        child: const Text(
          '8',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reorderables Page'),
        ),
        body: Center(
          child: ReorderableWrap(
            onReorder: onReorder,
            direction: Axis.horizontal,
            maxMainAxisCount: 2,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.center,
            spacing: 5.0,
            runSpacing: 5.0,
            children: tiles,
          ),
        ));
  }

  void onReorder(int oldIdx, int newIdx) {
    setState(() {
      Widget row = tiles
          .removeAt(oldIdx); // --> will return element<Widget> that is removed
      tiles.insert(newIdx,
          row); // --> inserting removed element<Widget> into new element
    });
  }
}
