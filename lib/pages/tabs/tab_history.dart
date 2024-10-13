import 'package:flutter/material.dart';
import './completed.dart';
import './inprogress.dart';

import '../../helpers/constant.dart';

class TabHistory extends StatelessWidget {
  const TabHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Warna.kuning,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Diproses'),
                Tab(
                  text: 'Selesai',
                ),
              ],
            ),
            title: const Text('Transaksi'),
          ),
          // body: const TabBarView(
          //   children: [],
          // ),
          body: const TabBarView(
            children: [InProgress(), Completed()],
          ),
        ),
      ),
    ));
  }
}
