import 'dart:developer';

import 'package:exp_app_vineet/Screen/add_expense_screen.dart';
import 'package:exp_app_vineet/app_constants/app_constants.dart';
import 'package:exp_app_vineet/exp_bloc/expense_bloc.dart';
import 'package:exp_app_vineet/exp_bloc/expense_event.dart';
import 'package:exp_app_vineet/exp_bloc/expense_state.dart';
import 'package:exp_app_vineet/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'drawer_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
  List<String> radioList = ['Day','Week','Month','Year','Category'];


class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpenseEvent());
  }

  // radio Button
  String radioCurrOption = radioList[0];
  // const MyHomePage({super.key});
  var switchVal = false;
  List<DateWiseExpenseModel> dateWiseExpenses = [];
  var dateFormat = DateFormat.yMd();



  // searchbar
  Icon cusIcon = Icon(Icons.search_rounded);
  // Widget cusS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense App"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.search_rounded,size: 30,),
          )
        ],
      ),
      drawer:  Drawer(
        backgroundColor: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                  // height: 50,
                  child: Text("Welcome", style: TextStyle(fontSize: 21),),
                ),
                Container(
                  child: Text(
                    "ID : Vineet Verma", style: TextStyle(fontSize: 21),),
                ),
                Divider(color: Colors.black,thickness: 1.5,),
                Divider(color: Colors.black,thickness: 1.2,),
                // Theme
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      child: Text(
                        "Select Your Theme  ", style: TextStyle(fontSize: 21),),
                    ),
                    Switch(
                      value: switchVal,
                      onChanged: (newValue) {
                        setState(() {
                          switchVal = newValue;
                        });
                      },
                    ),
                  ],
                ),
                Divider(color: Colors.black,thickness: 1.5,),
                // Radio Button View Mode
                Container(
                  child: Text("View Mode",style: TextStyle(fontSize: 21),),
                ),
                RadioListTile(
                  title: Text("${radioList[0]}",style: TextStyle(fontSize: 21),),
                  value: radioList![0],
                  groupValue: radioCurrOption,
                  onChanged: (value) {
                    setState(() {
                      radioCurrOption = value.toString();
                      log('pressed ${value}');
                    });
                  },
                ),
                RadioListTile(
                  title: Text("${radioList![1]}",style: TextStyle(fontSize: 21),),
                  value: radioList![1],
                  groupValue: radioCurrOption,
                  onChanged: (value) {
                    setState(() {
                      radioCurrOption = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("${radioList[2]}",style: TextStyle(fontSize: 21),),
                  value: radioList[2],
                  groupValue: radioCurrOption,
                  onChanged: (value) {
                    setState(() {
                      radioCurrOption = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("${radioList![3]}",style: TextStyle(fontSize: 21),),
                  value: radioList![3],
                  groupValue: radioCurrOption,
                  onChanged: (value) {
                    setState(() {
                      radioCurrOption = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("${radioList![4]}",style: TextStyle(fontSize: 21),),
                  value: radioList![4],
                  groupValue: radioCurrOption,
                  onChanged: (value) {
                    setState(() {
                      radioCurrOption = value.toString();
                    });
                  },
                ),


                Divider(color: Colors.black,thickness: 1.5,),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Add Expense",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddExpenseScreen();
          },));
        },
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {

          if (state is ExpenseLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ExpenseErrorState) {
            return Center(child: Text("${state.errorMsg}"),);
          }

          if (state is ExpenseLoadedState) {
            /// For Checking Date
            // state.loadData.forEach((element) {
            //   print(element.toMap().toString());
            // });

            filterDayWiseExpenses(state.loadData);

            return ListView.builder(
              itemCount: dateWiseExpenses.length,
              itemBuilder: (context, index) {
                var eachItem = dateWiseExpenses[index];
                var tdate_0 = dateFormat.format(DateTime.now());
                var tdata_1 = dateFormat.format(DateTime.now().subtract(Duration(days: 1)));

                return Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${eachItem.date==tdate_0?"Today":eachItem.date==tdata_1?"Yesturday":eachItem.date }', style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                            Text('${eachItem.totalAmt}',style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Divider(color: Colors.black,thickness: 1.5),
                        ListView.builder(
                          itemCount: eachItem.allTransaction.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, childindex) {
                            var eachChildTrans = eachItem.allTransaction[childindex];
                            return ListTile(
                              onTap: () {
                                // return print("${index + 1} - ${childindex+1}");
                                BlocProvider.of<ExpenseBloc>(context).add(DeleteExpenseEvent(id: childindex  ) );
                              },
                              leading: Image.asset('${AppConstants.mCategory[eachChildTrans.expCatID].catImgPath }'),
                              title: Text('${eachChildTrans.expTitle}'),
                              subtitle: Text('${eachChildTrans.expDesc}'),
                              trailing: Text('${eachChildTrans.expAmt}'),
                            );
                            },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
  ///date view
  DateFormat dateView(){
    var dateFormat = DateFormat.yMd();
    var day = DateFormat.yMd();
    var month = DateFormat.M();
    var week = DateFormat.E();
    var year = DateFormat.y();
    if(radioList =="Year"){
      log('year');
      log('year');
      dateFormat = year;
      // BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpenseEvent());
    }
    else if(radioList =="Month"){
      dateFormat = month;
      // BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpenseEvent());
    }
    else if(radioList =="Week"){
      dateFormat = week;
      // BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpenseEvent());
    }
    else{
      dateFormat = day;
      // BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpenseEvent());
    }
    // BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpenseEvent());
    return dateFormat;

  }

  // void filterCategoryWiseExpense(List<ExpenseModel> catfilterExpenses) asysc{
  //   print(radioCurrOption);
  // }


  void filterDayWiseExpenses(List<ExpenseModel> allExpenses) {
    print(radioList);
    print(dateFormat);
    dateFormat = dateView();
    dateWiseExpenses.clear();
    var listUniqueDate = [];

    for (ExpenseModel eachExp in allExpenses) {
      var eachDate = DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expTimeStamp));

      var date = dateFormat.format(eachDate);

      !listUniqueDate.contains(date) ? listUniqueDate.add(date) : '';
    }
    print(listUniqueDate);

    for (String date in listUniqueDate) {
      List<ExpenseModel> eachDateExp = [];
      var totalAmt = 0.0;

      for (ExpenseModel eachExp in allExpenses) {
        var eachDate = DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expTimeStamp));
        var mdate = dateFormat.format(eachDate);

        if (date == mdate) {
          eachDateExp.add(eachExp);

          if (eachExp.expType == 0) {
            totalAmt -= eachExp.expAmt;
          }
          else {
            totalAmt += eachExp.expAmt;
          }
        }
      }

      dateWiseExpenses.add(DateWiseExpenseModel(
          date: date,
          totalAmt: totalAmt.toString(),
          allTransaction: eachDateExp ));
    }
  }
}
