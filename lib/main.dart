// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' as Math;

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: Todolist()),
  );
}

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late AnimationController _celebrationController;
  late AnimationController _fabController;
  late Animation<double> _celebrationAnimation;
  late Animation<double> _fabAnimation;
  late ConfettiController _confettiController;

  final List<Map<String, dynamic>> _tasks = [
    {"title": "Example Task", "completed": false},
  ];

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    _celebrationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _celebrationController, curve: Curves.elasticOut),
    );

    _fabAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    _fabController.dispose();
    _textController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _addTask() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add({"title": text, "completed": false});
        _textController.clear();
      });

      _fabController.forward().then((_) => _fabController.reverse());
      HapticFeedback.lightImpact();
    }
  }

  void _toggleCompletion(int index) {
    setState(() {
      _tasks[index]["completed"] = !_tasks[index]["completed"];
    });

    if (_tasks[index]["completed"]) {
      _celebrationController.forward().then(
        (_) => _celebrationController.reset(),
      );
      _confettiController.play();
      HapticFeedback.mediumImpact();
    }
  }

  void _deleteTask(int index) {
    setState(() => _tasks.removeAt(index));
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    final int taskCount = _tasks.length;
    final int completedCount =
        _tasks.where((task) => task["completed"] == true).length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              "My Tasks",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$completedCount of $taskCount completed",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (taskCount > 0)
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            "${((completedCount / taskCount) * 100).round()}%",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: completedCount / taskCount,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                        minHeight: 8,
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    final bool isCompleted = task["completed"] == true;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: isCompleted ? 2 : 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: isCompleted ? Colors.green[100] : Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            task["title"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color:
                                  isCompleted
                                      ? Colors.grey[600]
                                      : Colors.grey[800],
                              decoration:
                                  isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                            ),
                          ),
                          leading: GestureDetector(
                            onTap: () => _toggleCompletion(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color:
                                    isCompleted
                                        ? Colors.green
                                        : Colors.transparent,
                                border: Border.all(
                                  color:
                                      isCompleted ? Colors.green : Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child:
                                  isCompleted
                                      ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                      : null,
                            ),
                          ),
                          trailing:
                              isCompleted
                                  ? IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _deleteTask(index),
                                  )
                                  : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: "Add a new task...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _addTask(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedBuilder(
                      animation: _fabAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _fabAnimation.value,
                          child: ElevatedButton(
                            onPressed: _addTask,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              fixedSize: const Size(56, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 🎉 Confetti at the top center
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.blue,
                Colors.green,
                Colors.pink,
                Colors.orange,
              ],
              createParticlePath: _drawStar,
            ),
          ),

          // 🎊 Celebration Card
          AnimatedBuilder(
            animation: _celebrationAnimation,
            builder: (context, child) {
              return _celebrationAnimation.value > 0
                  ? Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        alignment: Alignment.center,
                        child: Transform.scale(
                          scale: _celebrationAnimation.value,
                          child: Opacity(
                            opacity: (1.0 - _celebrationAnimation.value).clamp(
                              0.0,
                              1.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.celebration,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Good Job!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Task completed!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  // 🌟 Draw a star path for confetti
  Path _drawStar(Size size) {
    double degToRad(double deg) => deg * (Math.pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final path = Path();
    final angle = 360 / numberOfPoints;

    for (int i = 0; i < numberOfPoints; i++) {
      final x1 = halfWidth + externalRadius * Math.cos(degToRad(angle * i));
      final y1 = halfWidth + externalRadius * Math.sin(degToRad(angle * i));
      final x2 =
          halfWidth +
          internalRadius * Math.cos(degToRad(angle * i + angle / 2));
      final y2 =
          halfWidth +
          internalRadius * Math.sin(degToRad(angle * i + angle / 2));
      if (i == 0) {
        path.moveTo(x1, y1);
      } else {
        path.lineTo(x1, y1);
      }
      path.lineTo(x2, y2);
    }
    path.close();
    return path;
  }
}
