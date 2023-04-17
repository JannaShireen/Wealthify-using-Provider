import 'package:provider/provider.dart';
import 'package:wealthify/Insights/widgets/screen_all.dart';
import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';
import 'package:wealthify/db/models/transaction_model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealthify/provider/transaction_provider.dart';

class ScreenIncomeChart extends StatelessWidget {
  const ScreenIncomeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 205, 204, 204),
        body: Consumer<ProviderTransaction>(
          builder: (context, value, child) {
            var allIncome = value.overviewGraphTransactions
                .where((element) => element.type == CategoryType.income)
                .toList();
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
                    series: <CircularSeries>[
                      PieSeries<TransactionModel, String>(
                        dataSource: allIncome,
                        xValueMapper: (TransactionModel incomeDate, _) =>
                            incomeDate.category.name,
                        yValueMapper: (TransactionModel incomeDate, _) =>
                            incomeDate.amount,
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
