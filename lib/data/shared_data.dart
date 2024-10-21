// import 'package:expense_tracker/models/expense.dart';
import 'package:hive/hive.dart';

class SharedData{
  List expenses = [];

  final _myBox = Hive.box('newbox');

  void loadData(){
    expenses = _myBox.get("expenses");
  }

  void updateData(){
    _myBox.put("expenses", expenses);
  }
}