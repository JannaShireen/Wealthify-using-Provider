import 'package:provider/provider.dart';
import 'package:wealthify/db/db_functions/db_category_functions.dart';

import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';
import 'package:wealthify/db/models/transaction_model/transaction_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealthify/provider/add_transaction_provider.dart';
import 'package:wealthify/provider/category_provider.dart';
import 'package:wealthify/provider/transaction_provider.dart';

class ScreenAddIncomeTransaction extends StatelessWidget {
  ScreenAddIncomeTransaction({super.key});

  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderTransaction>(context).refreshUi();
    Provider.of<CategoryProvider>(context).refreshUI();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 204, 204),
      appBar: AppBar(
        title: Text('Add Income Transaction'),
        backgroundColor: Color.fromARGB(255, 11, 6, 6),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/IncomeImage.png'),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black26,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'How did you get it?',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            } else {
                              return null;
                            }
                          },
                          controller: _purposeTextEditingController,
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black26,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'How much?',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            } else {
                              return null;
                            }
                          },
                          controller: _amountTextEditingController,
                          keyboardType: TextInputType.number,
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Center(
                            child: Consumer<AddTransactionProvider>(
                                builder: (context, value, child) {
                              return TextButton(
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(width: 1.0),
                                  // backgroundColor: themeDarkBlue,
                                  foregroundColor: Colors.blue,
                                  // primary: Colors.black,
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                                onPressed: (() async {
                                  final selectedTempDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now().subtract(
                                        const Duration(
                                          days: 30,
                                        ),
                                      ),
                                      lastDate: DateTime.now(),
                                      helpText: 'select a Date');
                                  value.dateSelection(selectedTempDate);
                                }),
                                child: Text(
                                  value.selectedDateTime == null
                                      // ? 'Select Date'
                                      ? parseDateTime(DateTime.now())
                                      : parseDateTime(context
                                          .read<AddTransactionProvider>()
                                          .selectedDateTime),
                                ),
                              );
                            }),
                          ),
                        ),
                        Consumer2<AddTransactionProvider, CategoryProvider>(
                          builder: (context, tProvider, cProvider, child) {
                            return DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Select category";
                                }
                                return null;
                              },
                              hint: const Text('Select Income'),
                              value: tProvider.categoryId,
                              items: cProvider.incomeCategoryProvider.map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name),
                                  onTap: () {
                                    Provider.of<CategoryProvider>(context)
                                        .refreshUI();

                                    tProvider.selectedCategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                print(selectedValue);
                                tProvider.categoryId = selectedValue;
                                // setState(() {
                                //   _categoryID = selectedValue;
                              },
                            );
                          },
                        ),

                        //submit

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Transaction Added Successfully')),
                              );
                            }
                            submitAddIncomeTransaction(context);
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String parseDateTime(DateTime date) {
    final dateFormatted = DateFormat.MMMMd().format(date);
    //using split we split the date into two parts
    final splitedDate = dateFormatted.split(' ');
    //here _splitedDate.last is second word that is month name and other one is the first word
    return "${splitedDate.last}  ${splitedDate.first} ";
  }

  Future<void> submitAddIncomeTransaction(context) async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }

    if (_categoryID == null) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }
    final parsedAmount = double.tryParse(_amountText);
    if (parsedAmount == null) {
      return;
    }

    if (_selectedCategoryModel == null) {
      return;
    }

    final model = TransactionModel(
      purpose: _purposeText,
      amount: parsedAmount,
      date: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedDateTime,
      type: CategoryType.income,
      category: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedCategoryModel!,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    await Provider.of<ProviderTransaction>(context, listen: false)
        .addTransaction(model);
    // await TransactionDB.instance.addTransaction(model);
    Navigator.of(context).pop();
  }
}
