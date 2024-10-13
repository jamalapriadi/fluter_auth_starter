import 'package:flutter/material.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  

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