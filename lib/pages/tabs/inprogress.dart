import 'package:flutter/material.dart';

class InProgress extends StatefulWidget {
  const InProgress({super.key});

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0, top: 10),
        child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 30),
                      Text('Data not found.', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
      )
    );
  }

  
}