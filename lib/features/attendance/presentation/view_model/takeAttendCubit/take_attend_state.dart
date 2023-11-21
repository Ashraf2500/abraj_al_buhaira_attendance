part of 'take_attend_cubit.dart';

@immutable
abstract class TakeAttendState {}

class TakeAttendInitial extends TakeAttendState {}

class TakeAttendEmployeeState extends TakeAttendState{
  final EmployeeAttendModel employee ;
  TakeAttendEmployeeState(this.employee);
}

class RemoveAttendEmployeeState extends TakeAttendState{
  final EmployeeAttendModel employee ;
  RemoveAttendEmployeeState(this.employee);
}
