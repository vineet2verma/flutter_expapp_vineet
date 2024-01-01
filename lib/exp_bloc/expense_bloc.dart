import 'package:bloc/bloc.dart';
import '../db/app_db.dart';
import '../models/expense_model.dart';
import 'expense_event.dart';
import 'expense_state.dart';


class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  AppDataBase db;

  ExpenseBloc({required this.db}) : super(ExpenseInitial()) {
      
      /// Add Expense
      on<AddExpenseEvent>((event, emit) async {
        emit(ExpenseLoadingState());
        var check = await db.addExpenses(event.newExpense);
        if (check) {
          var mExp = await db.fetchAllExpense();
          emit(ExpenseLoadedState(loadData: mExp));
        } else {
          emit(ExpenseErrorState(errorMsg: "Expense not added!!!"));
        }
      });

      /// Fetch Expense
      on<FetchAllExpenseEvent>((event, emit) async {
        emit(ExpenseLoadingState());
        var mExp = await db.fetchAllExpense();
        emit(ExpenseLoadedState(loadData: mExp));
      });

      on<DeleteExpenseEvent>((event, emit)async{
        emit(ExpenseLoadingState());
        await db.deleteExpense(event.id );
        var mExp = await db.fetchAllExpense();
        emit(ExpenseLoadedState(loadData: mExp ));
      });


      /// Update Expense
      /*on<UpdateExpenseEvent>((event, emit) async {
        emit(ExpenseLoadingState());
        db.updateExpense(event.updateExpense);
        var mExp = await db.fetchAllExpense();
        emit(ExpenseLoadedState(loadData: mExp));
      });*/

      /// Delete Expense
    ///


      
      
      

  }
}




