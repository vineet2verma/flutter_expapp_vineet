import 'package:exp_app_vineet/Screen/add_expense_screen.dart';
import 'package:exp_app_vineet/db/app_db.dart';
import 'package:exp_app_vineet/exp_bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screen/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ExpenseBloc(db: AppDataBase.instance ),
      child: const MyApp(),
    )



  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          centerTitle: true,
        ),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

