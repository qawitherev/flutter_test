// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ColumnDraggablePage extends StatelessWidget {
//
//   final c = Get.put(ColumnDraggableController());
//
//   ColumnDraggablePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(c.appBar),),
//     );
//   }
// }
//
// class Tile2x1 extends StatelessWidget {
//   final Color color;
//   const Tile2x1({required this.color, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: color,
//       width: 100,
//       height: 50,
//       child: const Center(child: Text('2x1', style: TextStyle(color: Colors.white),),),
//     );
//   }
// }
//
// class Tile2x2 extends StatelessWidget {
//   final Color color;
//   const Tile2x2({required this.color, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: color,
//       width: 100,
//       height: 100,
//       child: const Center(child: Text('2x1', style: TextStyle(color: Colors.white),),),
//     );
//   }
// }
//
//
// class ColumnDraggableController extends GetxController {
//   final appBar = 'ColumnDraggable';
//   List<TileData> column1Tiles = [
//     TileData(tile: const Tile2x2(color: Colors.red), size: 2),
//     TileData(tile: const Tile2x2(color: Colors.red), size: 2),
//     TileData(tile: const Tile2x1(color: Colors.blue), size: 1),
//   ];
//   List<TileData> column2Tiles = [
//     TileData(tile: const Tile2x2(color: Colors.red), size: 2),
//     TileData(tile: const Tile2x2(color: Colors.red), size: 2),
//     TileData(tile: const Tile2x2(color: Colors.blue), size: 1),
//   ];
// }
//
// class TileData {
//   final Widget tile;
//   final int size; //1 for 2x1, 2 for 2x2
//
//   TileData({required this.tile, required this.size});
//
// }

import 'package:flutter/material.dart';

class Tile2x1 extends StatelessWidget {
  final Color color;

  Tile2x1({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: color,
        width: 100,
        height: 50,
        child: Center(
          child: Text(
            'Tile 2x1',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class Tile2x2 extends StatelessWidget {
  final Color color;

  Tile2x2({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: color,
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            'Tile 2x2',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class TileData {
  final Widget tile;
  final int size; // 1 for Tile2x1, 2 for Tile2x2

  TileData({required this.tile, required this.size});
}

class ColumnDraggablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TileData> column1Tiles = [
    TileData(tile: Tile2x1(color: Colors.red), size: 1),
    TileData(tile: Tile2x2(color: Colors.green), size: 2),
  ];

  List<TileData> column2Tiles = [
    TileData(tile: Tile2x2(color: Colors.blue), size: 2),
  ];

  Widget buildTile(TileData tileData) {
    return Draggable(
      data: tileData,
      child: tileData.tile,
      feedback: Opacity(
        opacity: 0.5,
        child: tileData.tile,
      ),
    );
  }

  Widget buildDragTarget(int columnIndex) {
    return DragTarget<TileData>(
      builder: (context, candidateData, rejectedData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columnData(columnIndex).map((tileData) => buildTile(tileData)).toList(),
        );
      },
      onWillAccept: (data) {
        return columnData(columnIndex).isEmpty || (columnData(columnIndex).last.size != data?.size);
      },
      onAccept: (data) {
        if (columnData(columnIndex).isEmpty) {
          setState(() {
            if (columnIndex == 0) {
              column1Tiles.remove(data);
            } else {
              column2Tiles.remove(data);
            }
            columnData(columnIndex).add(data);
          });
        } else {
          setState(() {
            if (columnIndex == 0) {
              column1Tiles.remove(data);
              column2Tiles.add(data);
            } else {
              column2Tiles.remove(data);
              column1Tiles.add(data);
            }
          });
        }
      },
    );
  }

  List<TileData> columnData(int columnIndex) {
    return columnIndex == 0 ? column1Tiles : column2Tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Tiles'),
      ),
      body: Row(
        children: [
          Expanded(
            child: buildDragTarget(0),
          ),
          Expanded(
            child: buildDragTarget(1),
          ),
        ],
      ),
    );
  }
}
