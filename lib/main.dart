import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fishing Planet Map',
      theme: ThemeData.dark(),
      home: const MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TransformationController _transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    // 獲取螢幕尺寸，用來計算盒子大小
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lone Star Lake - Bait Map'),
        elevation: 0,
        backgroundColor: const Color(0xFF1A1A1A),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _transformationController.value = Matrix4.identity();
            },
            tooltip: '重設地圖',
          )
        ],
      ),
      body: Container(
        color: const Color(0xFF121212), // 全螢幕背景色
        width: double.infinity,
        height: double.infinity,
        child: Center(
          // --- 這裡就是「地圖盒子」 ---
          child: Container(
            width: screenSize.width * 0.85, // 寬度佔螢幕 85%
            height: screenSize.height * 0.75, // 高度佔螢幕 75%
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16), // 圓角盒子
              border: Border.all(color: Colors.white12, width: 1), // 細緻邊框
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            // 使用 ClipRRect 確保縮放的地圖內容不會超出盒子的圓角邊界
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: InteractiveViewer(
                transformationController: _transformationController,
                clipBehavior: Clip.hardEdge, // 關鍵：強制縮放內容留在盒子內
                minScale: 0.5,
                maxScale: 10.0,
                boundaryMargin: const EdgeInsets.all(50),
                child: Center(
                  child: Image.asset(
                    'assets/texas_map.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}