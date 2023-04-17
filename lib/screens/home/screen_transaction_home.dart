import 'package:provider/provider.dart';

import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';
import 'package:wealthify/db/models/transaction_model/transaction_model.dart';
import 'package:wealthify/provider/transaction_provider.dart';
import 'package:wealthify/screens/category/screen_category.dart';
import 'package:wealthify/screens/widgets/add_transaction/add_expense_transaction.dart';
import 'package:wealthify/screens/widgets/add_transaction/add_income_transaction.dart';
import 'package:wealthify/screens/widgets/recent_transaction/recent_transaction.dart';
import 'package:wealthify/transactions/list_view_all.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderTransaction>(context, listen: false)
              .overviewGraphTransactions =
          Provider.of<ProviderTransaction>(context, listen: false)
              .transactionListProvider;
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 204, 204),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: circularMenu(context),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 6, 6),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Wealthify',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 280,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      //color: Color.fromARGB(255, 240, 207, 207),
                    ),
                    width: double.infinity,
                    height: 150,
                  ),
                  Positioned(
                    top: 20,
                    left: 30,
                    right: 30,
                    child: Card(
                      color: Colors.black26,
                      elevation: 9,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        height: 250,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: Consumer<ProviderTransaction>(builder:
                              (context, incomeAndExpenseProvider, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      incomeAndExpenseProvider.totalBalance < 0
                                          ? 'Lose'
                                          : 'Total',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 74, 73, 73),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '₹${incomeAndExpenseProvider.totalBalance.abs().toString()}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          color: Colors.green,
                                        ),

                                        padding: const EdgeInsets.all(1.0),
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 20, right: 10),
                                        height: 60,
                                        width: 30,
                                        // color: Colors.green,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              'Income',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '₹${incomeAndExpenseProvider.incomeTotal!}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(1.0),
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 20,
                                        ),
                                        height: 60,
                                        width: 30,
                                        // color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              'Expense',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '₹${incomeAndExpenseProvider.expenseTotal.toString()}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              height: 2,
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Consumer<ProviderTransaction>(
                    builder: (context, newList, child) {
                      return newList.transactionListProvider.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                elevation: 0,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return ListViewAllTransactions();
                                    }),
                                  ),
                                );
                              }),
                              child: const Text(
                                'See All',
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black26,
                height: 80,
                child: RecentTransactionList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget circularMenu(BuildContext context) {
    return CircularMenu(
        alignment: Alignment.bottomCenter,
        toggleButtonColor: Colors.black,
        items: [
          CircularMenuItem(
              color: Colors.green,
              icon: Icons.arrow_upward_rounded,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenAddIncomeTransaction()));
                // callback
              }),
          CircularMenuItem(
              color: Colors.red,
              icon: Icons.arrow_downward_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenAddExpenseTransaction()),
                );
                //callback
              }),
          CircularMenuItem(
              color: Colors.blue,
              icon: Icons.category_rounded,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScreenCategory()));
                //callback
              }),
        ]);
  }
}
