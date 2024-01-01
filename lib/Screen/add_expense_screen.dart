
import 'dart:math';

import 'package:exp_app_vineet/Screen/drawer_screen.dart';
import 'package:exp_app_vineet/app_constants/app_constants.dart';
import 'package:exp_app_vineet/exp_bloc/expense_bloc.dart';
import 'package:exp_app_vineet/exp_bloc/expense_event.dart';
import 'package:exp_app_vineet/models/expense_model.dart';
import 'package:exp_app_vineet/widget_constants/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerAmt = TextEditingController();

  DateTime expDate = DateTime.now();
  String selectedTransactionType = "Debit";
  var selectCatIndex = -1;

  Future<void> _selectDate(BuildContext context) async{
    final DateTime? pickExpDate = await showDatePicker(
        context: context,
        initialDate: expDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now()
    );
    if (pickExpDate != null ){
      setState(() {
        expDate = pickExpDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expenses"),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controllerName,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                  labelText: "Name Your Expense",
                  suffixText: "ABC",
                ),
              ),
            ),
            // SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controllerDesc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                  labelText: "Add Description",
                  suffixIcon: Icon(Icons.abc),
                ),
              ),
            ),
            // SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controllerAmt,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                  labelText: "Enter Amount",
                  suffixText: "ABC",
                ),
              ),
            ),
            // SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  style: TextStyle(color: Colors.black,fontSize: 26,),
                  value: selectedTransactionType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTransactionType = newValue.toString();
                    });
                  },
                  items: ["Debit","Credit"].map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }
                  ).toList(),
                ),
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  CustomeElevatedButton(
                    name: "Choose Expenses",
                    btnColor: Colors.white,
                    textColor: Colors.black,
                    widget: selectCatIndex != -1
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppConstants.mCategory[selectCatIndex].catImgPath,
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          "  -  ${AppConstants.mCategory[selectCatIndex].catTitle}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                        : null,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return GridView.builder(
                              itemCount: AppConstants.mCategory.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4
                              ),
                              itemBuilder: (context, index) {
                                var eachCategory = AppConstants.mCategory[index];
                                return InkWell(
                                  onTap: () {
                                    return
                                        setState(() {
                                          selectCatIndex = index;
                                          Navigator.pop(context);
                                        });
                                  },
        
                                  child: Container(
                                    margin: EdgeInsets.all(11),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan.shade100,
                                      borderRadius: BorderRadius.circular(21)
                                    ),
                                    child: Image.asset(eachCategory.catImgPath),
                                  ),
                                );
                              },
        
        
                            );
                          },
                      );
                    },
        
        
        
                  ),
        
                  CustomeElevatedButton(
                      name: DateFormat.yMMMd().format(expDate),
                      btnColor: Colors.white54,
                      textColor: Colors.black,
                      onTap: () {
                        setState(() {
                          _selectDate(context);
                          expDate;
                        });
                      },
                  ),
        
                  CustomeElevatedButton(
                      name: "Add Expense",
                      btnColor: Colors.black,
                      textColor: Colors.white,
                      onTap: () {
                        if(controllerName.text.isNotEmpty &&
                            controllerDesc.text.isNotEmpty &&
                            controllerAmt.text.isNotEmpty &&
                            selectCatIndex != -1
                        )
                        {
                          var newExpense = ExpenseModel(
                              expId: 0,
                              uId: 0,
                              expTitle: controllerName.text.toString(),
                              expDesc: controllerDesc.text.toString(),
                              expTimeStamp: expDate.millisecondsSinceEpoch.toString(),
                              expAmt: int.parse(controllerAmt.text.toString()),
                              expBal: 0,
                              expType: selectedTransactionType=="Debit"? 0 : 1,
                              expCatID: selectCatIndex
                          );

                          BlocProvider.of<ExpenseBloc>(context).add(AddExpenseEvent(newExpense: newExpense));
                        }
                        Navigator.pop(context);
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
        
          ],
        ),
      ),
    );
  }
}
