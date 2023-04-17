import 'package:provider/provider.dart';
import 'package:wealthify/db/db_functions/income_and_expense.dart';
import 'package:wealthify/db/models/transaction_model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealthify/provider/transaction_provider.dart';

// ValueNotifier<List<TransactionModel>> overViewGraphNotifier =
//     ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class ScreenAll extends StatelessWidget {
  ScreenAll({super.key});

  late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 205, 204, 204),
        body: Consumer<ProviderTransaction>(
          builder: (context, value, child) {
            Map incomeMap = {'name': 'Income', "amount": value.incomeTotal};
            Map expenseMap = {"name": "Expense", "amount": value.expenseTotal};
            List<Map> totalMap = [incomeMap, expenseMap];
            return value.overviewGraphTransactions.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Center(child: Text('No data Found')),
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<Map, String>(
                        dataSource: totalMap,
                        xValueMapper: (Map data, _) => data['name'],
                        yValueMapper: (Map data, _) => data['amount'],
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      )
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      alignment: ChartAlignment.center,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
