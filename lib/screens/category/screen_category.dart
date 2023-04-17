import 'package:provider/provider.dart';
import 'package:wealthify/provider/category_provider.dart';
import 'package:wealthify/screens/category/category_bottom_sheet.dart.dart';
import 'package:wealthify/screens/category/expense_category_list.dart';
import 'package:wealthify/screens/category/income_category_list.dart';
import 'package:flutter/material.dart';

class Data {
  String label;
  Color color;

  Data(this.label, this.color);
}

class ScreenCategory extends StatelessWidget {
  ScreenCategory({super.key});

  // bool isGridView=true;
  List<Widget> chips = [];
  int? _curIndex = 0;
  //  int _selectedIndex=0;
  final List<Data> _choiceChipsList = [
    Data("Income", Colors.green),
    Data("Expense", Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).refreshUI();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 205, 204, 204),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 6, 6),
          title: const Text(
            'Categories',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: TabBar(
              dividerColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              onTap: (value) {
                _curIndex = value;
                // print(value);
              },
              tabs: const [
                Tab(
                  icon: Icon(Icons.arrow_upward),
                  text: 'Income',
                ),
                Tab(
                  icon: Icon(Icons.arrow_downward),
                  text: 'Expense',
                )
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
                      categoryShowBottomSheetApp(context);


            // print('Add something');
          },
          child: const Icon(Icons.add),
        ),
        body: const TabBarView(children: [
          IncomeCategoryList(),
          ExpenseCategoryList(),
        ]),
      ),
    );
  }
}
