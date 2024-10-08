import 'dart:math';

import 'package:budgetapp/datetime/data_time_helper.dart';
import 'package:budgetapp/models/expense_item.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
  }

  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';

      case 2:
        return 'Tue';

      case 3:
        return 'Wed';

      case 4:
        return 'Thur';

      case 5:
        return 'Fri';

      case 6:
        return 'Sat';

      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpenseSumary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}
