import 'package:provider/provider.dart';
import 'package:wealthify/Insights/widgets/screen_all.dart';
import 'package:wealthify/Insights/widgets/screen_expense_chart.dart';
import 'package:wealthify/Insights/widgets/screen_income_chart.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:wealthify/provider/transaction_provider.dart';

class InsightPage extends StatelessWidget {
  InsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        context.read<ProviderTransaction>().overviewGraphTransactions =
            context.read<ProviderTransaction>().transactionListProvider);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 204, 204),
      appBar: AppBar(
        title: Text('Insights'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 11, 6, 6),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  'Date  ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<ProviderTransaction>(builder: (context, value, child) {
                  return PopupMenuButton<int>(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        70,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 15.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            value.dateFilterTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: const Text(
                          "All",
                        ),
                        onTap: () {
                          value.setOverViewGraphTransactions =
                              value.transactionListProvider;
                          value.dateFilterTitle = "All";
                        },
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: const Text(
                          "Today",
                        ),
                        onTap: () {
                          value.setOverViewGraphTransactions =
                              value.transactionListProvider;
                          value.setOverViewGraphTransactions = value
                              .overviewGraphTransactions
                              .where((element) =>
                                  element.date.day == DateTime.now().day &&
                                  element.date.month == DateTime.now().month &&
                                  element.date.year == DateTime.now().year)
                              .toList();

                          value.dateFilterTitle = "Today";
                        },
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: const Text(
                          "Yesterday",
                        ),
                        onTap: () {
                          value.setOverViewGraphTransactions =
                              value.transactionListProvider;
                          value.setOverViewGraphTransactions = value
                              .overviewGraphTransactions
                              .where((element) =>
                                  element.date.day == DateTime.now().day - 1 &&
                                  element.date.month == DateTime.now().month &&
                                  element.date.year == DateTime.now().year)
                              .toList();

                          value.dateFilterTitle = "Yesterday";
                        },
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: const Text(
                          "Month",
                        ),
                        onTap: () {
                          value.setOverViewGraphTransactions =
                              value.transactionListProvider;
                          value.setOverViewGraphTransactions = value
                              .overviewGraphTransactions
                              .where((element) =>
                                  element.date.month == DateTime.now().month &&
                                  element.date.year == DateTime.now().year)
                              .toList();

                          value.dateFilterTitle = "Month";
                        },
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    // transformAlignment: Alignment.center,

                    width: double.infinity,
                    child: ButtonsTabBar(
                      backgroundColor: Colors.black,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 40),
                      tabs: const [
                        Tab(
                          iconMargin: EdgeInsets.all(30),
                          text: 'All',
                        ),
                        Tab(
                          text: 'Income',
                        ),
                        Tab(
                          text: 'Expense',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    ScreenAll(),
                    ScreenIncomeChart(),
                    ScreenExpenseChart(),
                  ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
