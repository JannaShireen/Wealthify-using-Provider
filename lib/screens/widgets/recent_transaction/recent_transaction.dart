import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';
import 'package:wealthify/parse_date/parse_date.dart';
import 'package:wealthify/provider/transaction_provider.dart';

class RecentTransactionList extends StatelessWidget {
  const RecentTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProviderTransaction>().refreshUi();
    return Consumer<ProviderTransaction>(
      builder: (context, newList, child) {
        return newList.transactionListProvider.isEmpty
            ? Center(
                child: Text('No transactions added yet'),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(5),
                itemBuilder: (ctx, index) {
                  final _value = newList.transactionListProvider[index];
                  return Card(
                    color: Colors.black26,
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 50,
                        child: Icon(
                          _value.type == CategoryType.income
                              ? Icons.arrow_upward_outlined
                              : Icons.arrow_downward_outlined,
                          color: _value.type == CategoryType.income
                              ? Color.fromARGB(255, 2, 155, 43)
                              : Color.fromARGB(255, 195, 0, 0),
                        ),
                      ),
                      // CircleAvatar(
                      //   radius: 50,

                      //   backgroundColor: _value.type == CategoryType.income ? Colors.green : Colors.red,
                      //   child: Text(
                      //     parseDate(_value.date),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      title: Text('RS ${_value.amount}'),
                      subtitle: Text(_value.category.name),
                      trailing: Text(
                        parseDateTime(_value.date),
                      ),
                      //
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    height: 4,
                    thickness: 2,
                  );
                },
                itemCount: newList.transactionListProvider.length > 4
                    ? 4
                    : newList.transactionListProvider.length,
              );
      },
    );
  }
}
