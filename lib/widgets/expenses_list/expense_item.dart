import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense,{super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w800
              ),
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('₦ ${expense.amount.toStringAsFixed(2)}', 
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                ),
                const Spacer(),
                Row(
                  children:[
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate)
                  ]
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}