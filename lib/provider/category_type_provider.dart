import 'package:flutter/material.dart';
import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';


class CategoryTypeProvider extends ChangeNotifier {
  CategoryType selectCategoryProvider = CategoryType.income;
  onChanging(value, newCategory) {
    if (value == null) {
      return;
    }
    if (selectCategoryProvider == CategoryType.income) {
      selectCategoryProvider = CategoryType.expense;

      notifyListeners();
    } else {
      selectCategoryProvider = CategoryType.income;
      notifyListeners();
    }
    selectCategoryProvider = newCategory;
    notifyListeners();
  }
}
