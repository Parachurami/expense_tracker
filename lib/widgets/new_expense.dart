import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSubmit});
  final Function(Expense) onSubmit;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:now,
      firstDate: firstDate, 
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      toastification.show(
        context: context,
        title: const Text('Invalid Input'),
        description: const Text('All Fields are required'),
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.error,
        primaryColor: Theme.of(context).colorScheme.primary
      );
      return;
    }
    widget.onSubmit(Expense(amount: enteredAmount, date: _selectedDate!, title: _titleController.text, category: _selectedCategory));
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return  LayoutBuilder(
      builder:(ctx, constraints) => SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardHeight + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text("Amount"),
                          prefixText: '₦ '
                        ),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate  == null ? "No Date Selected" : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _presentDatePicker, 
                            icon: const Icon(Icons.calendar_month_outlined)
                          )
                        ],
                      )
                    )
                  ],
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())
                        )
                      ).toList(), 
                      onChanged: (value){
                        if(value == null){
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: const Text("Cancel")
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData, 
                      child: const Text('Save Expense')
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}