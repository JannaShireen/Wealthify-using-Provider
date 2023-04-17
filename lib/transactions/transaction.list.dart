 
import 'package:provider/provider.dart';

import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';
import 'package:wealthify/db/models/transaction_model/transaction_model.dart';
import 'package:wealthify/provider/transaction_provider.dart';
import 'package:wealthify/transactions/list_view_all.dart';
import 'package:wealthify/screens/widgets/slidable/slidable_transaction.dart';
import 'package:flutter/material.dart';





    class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderTransaction>(
        builder: (BuildContext context, newList, Widget? _) {
             var displayList = [];
             if (newList.showCategory == "Income") {
        
        List<TransactionModel> incomeTransactionList = [];

        incomeTransactionList = newList.overviewTransactions
            .where((element) => element.type == CategoryType.income)
            .toList();
       
      } else if (newList.showCategory == "Expense") {
        List<TransactionModel> incomeTransactionList = [];
        incomeTransactionList = newList.overviewTransactions
            .where((element) => element.type == CategoryType.expense)
            .toList();
        displayList = incomeTransactionList;
      } else {
        displayList = newList.overviewTransactions;
      }

      
      
      
 
 
             
   return displayList.isEmpty?
                            SingleChildScrollView(
                              child: Center(
                                child: Text(
                                  'No transactions added yet'),)) 
                                                        
                             :ListView.separated(
                            padding: const EdgeInsets.all(5),
                            itemBuilder: (ctx, index) {
                              final transaction= displayList[index];
     
                              return  SlidableTransaction(transaction: transaction);
                            },
                            
     
                            separatorBuilder: (ctx, index) {
                              return const Divider(height: 5,
                              thickness: 5,);
                            },
                            itemCount: displayList.length);
     
           
            });
      }
                

  }
    
 