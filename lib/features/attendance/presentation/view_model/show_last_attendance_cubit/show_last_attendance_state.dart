part of 'show_last_attendance_cubit.dart';

@immutable
abstract class ShowLastAttendanceState {}

class ShowLastAttendanceInitial extends ShowLastAttendanceState {}

class ShowLastAttendanceLoadingState extends ShowLastAttendanceState{}

class ShowLastAttendanceSuccessState extends ShowLastAttendanceState{
  final ShowLastAttendanceModel ShowLastAttendanceData ;
  ShowLastAttendanceSuccessState({required this.ShowLastAttendanceData});
}
class ShowLastAttendanceErrorState extends ShowLastAttendanceState{

  final String errorMessage;

  ShowLastAttendanceErrorState({required this.errorMessage});
}