import 'package:provider/provider.dart';
import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';
import 'package:wealthify/db/models/transaction_model/transaction_model.dart';

import 'package:flutter/material.dart';

import 'package:wealthify/parse_date/parse_date.dart';
import 'package:wealthify/provider/add_transaction_provider.dart';
import 'package:wealthify/provider/category_provider.dart';
import 'package:wealthify/provider/transaction_provider.dart';

class EditIncomeTransaction extends StatelessWidget {
  EditIncomeTransaction({
    Key? key,
    required this.obj,
    this.id,
  }) : super(key: key);

  final String? id;
  final TransactionModel obj;

  // CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  // int _value = 0;
  TextEditingController _amountTextEditingController = TextEditingController();
  TextEditingController _purposeTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Provider.of<AddTransactionProvider>(context, listen: false).categoryId =
        obj.category.id;
    _amountTextEditingController =
        TextEditingController(text: obj.amount.toString());
    _purposeTextEditingController = TextEditingController(text: obj.purpose);
    Provider.of<AddTransactionProvider>(context, listen: false)
        .selectedDateTime = obj.date;
    Provider.of<AddTransactionProvider>(context, listen: false)
        .selectedCategoryType = CategoryType.income;
    Provider.of<AddTransactionProvider>(context, listen: false)
        .selectedCategoryModel = obj.category;
    // final size = MediaQuery.of(context).size;
    Provider.of<AddTransactionProvider>(context, listen: false).value =
        obj.type.index;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 204, 204),
      appBar: AppBar(
        title: Text('EDIT INCOME'),
        backgroundColor: Color.fromARGB(255, 11, 6, 6),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
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
                        controller: _purposeTextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field required';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Purpose',
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field required';
                          }
                        },
                        controller: _amountTextEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Amount',
                        ),
                        keyboardType: TextInputType.number,
                      ),

                      Consumer<AddTransactionProvider>(
                          builder: (context, value, child) {
                        return TextButton(
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
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(width: 1.0),
                            // backgroundColor: themeDarkBlue,
                            foregroundColor: Colors.blue,
                            // primary: Colors.black,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: Text(parseDateTime(value.selectedDateTime)),
                        );
                      }),
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
                                  _selectedCategoryModel = e;
                                },
                              );
                            }).toList(),
                            onChanged: ((selectedValue) {
                              tProvider.categoryId = selectedValue;
                            })

                            //
                            );
                      }),

                      //submit

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            submitEditIncomeTransaction(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Transaction Edited Successfully')),
                            );
                          }
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
    );
  }

  Future<void> submitEditIncomeTransaction(context) async {
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
        category: _selectedCategoryModel!,
        id: obj.id);

    await Provider.of<ProviderTransaction>(context, listen: false)
        .editTransaction(model);
    Navigator.of(context).pop();
  }
}
