import 'package:flutter/material.dart';

import '../../helpers/constant.dart';

class TabOther extends StatefulWidget {
  const TabOther({super.key});

  @override
  State<TabOther> createState() => _TabOtherState();
}

class _TabOtherState extends State<TabOther> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Warna.kuning,
          title: const Center(
                child: Text('OTHER', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
        ),
        body: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 30),
                      Text('Data not found.', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                    ],
                  ),
                )
      ),
    );
  }
}