import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getbulder_lesson/controller/NumberIncrementController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final buttons = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '%',
    '+',
    'C',
    'UNDO',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌈 Gradient background for the whole screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // colors: [
            //   Color(0xFF232526), // Dark grey
            //   Color(0xFF414345), // Lighter grey gradient
            // ],
            colors: [Color(0xFF141E30), Color(0xFF243B55)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: GetBuilder<CalculatorEngine>(
            builder: (calc) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 🧾 Display Screen
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF141E30), Color(0xFF243B55)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        children: buttons.map((btn) {
                          // 🎨 Button color logic
                          final isOperator = [
                            '/',
                            '*',
                            '-',
                            '+',
                            '=',
                            '%',
                          ].contains(btn);
                          final isUndo = btn == 'UNDO';
                          final isClear = btn == 'C';
                          final isEqual = btn == '=';

                          Color buttonColor;
                          if (isClear) {
                            buttonColor = Colors.redAccent;
                          } else if (isUndo) {
                            buttonColor = Colors.orangeAccent;
                          } else if (isOperator) {
                            buttonColor = Colors.blueAccent;
                          } else {
                            buttonColor = Colors.grey.shade800;
                          }

                          // 👇 Adjust button size: smaller padding overall
                          final buttonStyle = ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            shadowColor: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 8,
                            ),
                          );

                          // 👇 Make "=" button double width
                          if (isEqual) {
                            return GridTile(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: buttonStyle,
                                  onPressed: () {
                                    Get.find<CalculatorEngine>().btnPressed(
                                      btn,
                                    );
                                  },
                                  child: const Text(
                                    '=',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          // 🧩 Normal buttons
                          return ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              Get.find<CalculatorEngine>().btnPressed(btn);
                            },
                            child: Text(
                              btn,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
