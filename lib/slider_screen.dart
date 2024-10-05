import 'package:flutter/material.dart';
import 'dart:math';
import 'package:studyo_io_app/widgets/congrats.dart';
import 'package:studyo_io_app/widgets/grid_painter.dart';
import 'package:studyo_io_app/widgets/triangle_painter.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SliderScreen(),
    );
  }
}

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double horizontalSliderValue = 0;
  double verticalSliderValue = 0;
  int verticalLines = 0;
  int horizontalLines = 0;

  int tilesToCreate = 30;
  int tilesToSelect =
      4; // Number of tiles to select dynamically between 1 and 10
  int selectedTiles = 0;

  bool isSelectionEnabled = false;

  List<List<bool>> selectedTileStates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Background color of the AppBar
        leading: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(width: 50,),
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.grey), // Refresh icon
              onPressed: () {
                // Add functionality if needed
                _refreshTiles();
              },
            ),
          ],
        ),
        centerTitle: true, // Centers the title/content in the AppBar
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.green), // First star
            Icon(Icons.star, color: Colors.green), // Second star
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.grey), // Next icon
            onPressed: () {
              // Add functionality if needed
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Create $tilesToCreate tiles using the sliders',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Select $tilesToSelect tiles after creating',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    if (isSelectionEnabled)
                      Text(
                        'Selected $selectedTiles / $tilesToSelect',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: GestureDetector(
                        onTapDown: (details) {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final Offset localOffset = renderBox.globalToLocal(details.globalPosition);
  final double tileWidth = renderBox.size.width / (horizontalLines + 1);
  final double tileHeight = renderBox.size.height / (verticalLines + 1);
  
  final int row = (localOffset.dy / tileHeight).floor();
  final int col = (localOffset.dx / tileWidth).floor();
  
  // Call onTapTile with calculated row and col
  onTapTile(row, col);
},

                        child: Container(
                          color: Colors.grey.shade200,
                          child: CustomPaint(
                            painter: GridPainter(verticalLines, horizontalLines,
                                selectedTileStates),
                            child: Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Vertical Sliders on Left and Right sides
          Positioned(
            top: 470 - verticalSliderValue * 10,
            left: 10,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  verticalSliderValue =
                      (verticalSliderValue - details.delta.dy / 10)
                          .clamp(0, 10);
                  verticalLines = verticalSliderValue.toInt();
                  _initializeGridState();
                  _checkTilesCondition();
                });
              },
              child: CustomPaint(
                size: Size(30, 30),
                painter: TrianglePainter(
                    direction: 'right', lineCount: verticalLines),
              ),
            ),
          ),
          Positioned(
            top: 470 - verticalSliderValue * 10,
            right: 10,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  verticalSliderValue =
                      (verticalSliderValue - details.delta.dy / 10)
                          .clamp(0, 10);
                  verticalLines = verticalSliderValue.toInt();
                  _initializeGridState();
                  _checkTilesCondition();
                });
              },
              child: CustomPaint(
                size: Size(30, 30),
                painter: TrianglePainter(
                    direction: 'left', lineCount: verticalLines),
              ),
            ),
          ),
          // Horizontal Sliders on Top and Bottom sides
          Positioned(
            top: 140, // Top of the grid
            left: 170 + horizontalSliderValue * 10,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  horizontalSliderValue =
                      (horizontalSliderValue + details.delta.dx / 10)
                          .clamp(0, 10);
                  horizontalLines = horizontalSliderValue.toInt();
                  _initializeGridState();
                  _checkTilesCondition();
                });
              },
              child: CustomPaint(
                size: Size(30, 30),
                painter: TrianglePainter(
                    direction: 'down', lineCount: horizontalLines),
              ),
            ),
          ),
          Positioned(
            bottom: 140, // Bottom of the grid
            left: 170 + horizontalSliderValue * 10,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  horizontalSliderValue =
                      (horizontalSliderValue + details.delta.dx / 10)
                          .clamp(0, 10);
                  horizontalLines = horizontalSliderValue.toInt();
                  _initializeGridState();
                  _checkTilesCondition();
                });
              },
              child: CustomPaint(
                size: Size(30, 30),
                painter: TrianglePainter(
                    direction: 'up', lineCount: horizontalLines),
              ),
            ),
          ),
          Positioned(
              bottom: 60, 
              left: 130,
              child: ElevatedButton(
                 onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return CongratulationsDialog(
                  onClose: () {
                    _refreshTiles(); // Refresh the screen
                  },
                );
              },
            );
          },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.greenAccent, 
                ),
              ))
        ],
      ),

      backgroundColor:
          Colors.blueGrey[900], 
    );
  }

void _refreshTiles() {
  setState(() {
    // Generate an even number for tilesToCreate between 2 and 40
    tilesToCreate = (Random().nextInt(20) + 1) * 2; // Multiplies by 2 to ensure it's even

    // Generate a random number for tilesToSelect between 1 and 10
    tilesToSelect = Random().nextInt(10) + 1;

    selectedTiles = 0;
    _initializeGridState();
  });
}


  void _initializeGridState() {
    selectedTileStates = List.generate(
      verticalLines,
      (_) => List.generate(horizontalLines, (_) => false),
    );
  }

  void onTapTile(int row, int col) {
  // Check if the tapped tile is within bounds and if selection is enabled
  if (isSelectionEnabled &&
      selectedTiles < tilesToSelect &&
      row >= 0 &&
      row < verticalLines &&
      col >= 0 &&
      col < horizontalLines) {
    setState(() {
      if (!selectedTileStates[row][col]) {
        selectedTileStates[row][col] = true;
        selectedTiles++;
      }
    });
  }
}

  void _checkTilesCondition() {
    int totalTiles = verticalLines * horizontalLines;
    if (totalTiles >= tilesToCreate) {
      setState(() {
        isSelectionEnabled = true;
      });
    } else {
      setState(() {
        isSelectionEnabled = false;
        selectedTiles = 0;
        _initializeGridState();
      });
    }
  }
}

