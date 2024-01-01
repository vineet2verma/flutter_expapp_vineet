//part of 'expense_bloc.dart';


import '../models/expense_model.dart';

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  List<ExpenseModel> loadData;

  ExpenseLoadedState({required this.loadData});
}

class ExpenseErrorState extends ExpenseState {
  String errorMsg;

  ExpenseErrorState({required this.errorMsg});
}

