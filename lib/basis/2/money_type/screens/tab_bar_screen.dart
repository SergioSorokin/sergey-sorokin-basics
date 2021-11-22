import 'package:flutter/material.dart';
import 'package:pdp_project/basis/2/money_type/screens/calculation_screen.dart';
import 'package:pdp_project/basis/2/money_type/screens/money_type_screen.dart';

class TabBarScreen extends StatefulWidget {
  static const String routName = '/tabBarScreen';
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  String title = 'TabBarScreen';
  String message = '';
  final TextEditingController inputStringController = TextEditingController();
  final TextEditingController inputStringController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(
          'C',
          style: TextStyle(fontSize: 24),
        ),
        onPressed: () {
          if (_tabController.index == 0) {
            setState(() {
              inputStringController.clear();
            });
          } else if (_tabController.index == 1) {
            setState(() {
              inputStringController1.clear();
            });
          }
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: 'MoneyTypeScreen',
            ),
            Tab(
              text: 'CalculationScreen',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MoneyTypeScreen(inputStringController),
          CalculationScreen(inputStringController1),
        ],
      ),
    );
  }
}
