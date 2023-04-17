

import 'package:wealthify/filter/date_filter/date_filter_transaction.dart';
import 'package:wealthify/filter/type_filter/type_filter_transaction.dart';
import 'package:wealthify/screens/search/search_field.dart';
import 'package:flutter/material.dart';
import 'transaction.list.dart';

class ListViewAllTransactions extends StatelessWidget {
  const ListViewAllTransactions({

    super.key});

  
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 204, 204),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 6, 6),
        centerTitle: true,
        title: const Text(
          'All Transactions',
        ),
        actions:  [
          DAteFilterTransaction(),
          SizedBox(
            width: 10,
          ),
          TypeFilterClass(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [

          SearchField(),
          const Expanded(
            child: TransactionList(),
          ),
        ],
      ),
    );
  }
}
 
//       