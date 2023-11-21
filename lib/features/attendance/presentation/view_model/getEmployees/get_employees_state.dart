part of 'get_employees_cubit.dart';

@immutable
abstract class GetEmployeesState {}

class GetEmployeesInitial extends GetEmployeesState {}

class GetEmployeesLoadingState extends GetEmployeesState{}
class GetEmployeesSuccessState extends GetEmployeesState{
  final GetEmployeesModel getEmployeesData ;
  GetEmployeesSuccessState({required this.getEmployeesData});
}
class GetEmployeesErrorState extends GetEmployeesState{

  final String errorMessage;
  final bool logout;
  final bool tryAgain;

  GetEmployeesErrorState({required this.errorMessage,required this.logout,required this.tryAgain});
}