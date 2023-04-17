

import 'package:provider/provider.dart';

import 'package:wealthify/provider/transaction_provider.dart';

import 'package:flutter/material.dart';



class SearchField extends StatelessWidget {
  SearchField({super.key});
  final TextEditingController _searchQueryController = TextEditingController();
 // ValueNotifier<List<TransactionModel>> overViewListNotifier =
   // ValueNotifier(TransactionDB.instance.transactionListNotifier.value);
  @override
  Widget build(BuildContext context) {
    
     
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: _searchQueryController,
            onChanged: (query) {print(query);
              searchResult(query,context);
              // overViewListNotifier.notifyListeners();
            },
            decoration: InputDecoration(
                hintText: 'Search..',
                border: InputBorder.none,
                icon: const Icon(
                  Icons.search,
                  // color: textClr,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                     Provider.of<ProviderTransaction>(context,listen:false).overviewTransactions=
                     Provider.of<ProviderTransaction>(context,listen:false).transactionListProvider;
                     Provider.of<ProviderTransaction>(context,listen:false).notifyListeners();
                    },
                    icon: const Icon(
                      Icons.close,
                      // color: Colors.black,
                    ))),
          ),
        ),
      ),
    );
  }
}

  searchResult(String query, BuildContext context ){
 
    if (query.isEmpty) {
      Provider.of<ProviderTransaction>(context,listen:false).overviewTransactions =
          Provider.of<ProviderTransaction>(context,listen:false).transactionListProvider;
          Provider.of<ProviderTransaction>(context,listen:false).notifyListeners();
    } else {
     // overViewListNotifier.value.map((e) => debugPrint(e.purpose));
    
    Provider.of<ProviderTransaction>(context,listen:false).overviewTransactions
    = Provider.of<ProviderTransaction>(context,listen:false).overviewTransactions
          .where((element) =>
           element.category.name.toString()
              .toLowerCase()
              .contains(query.trim().toLowerCase())||element.purpose.contains(query.trim().toLowerCase()))

          .toList() ;
          Provider.of<ProviderTransaction>(context,listen:false).notifyListeners();
          
      

          //data.category.name.toString().toLowerCase().contains(query.toLowerCase()) || data.purpose.toLowerCase().contains(query.toLowerCase())
    }
  }
