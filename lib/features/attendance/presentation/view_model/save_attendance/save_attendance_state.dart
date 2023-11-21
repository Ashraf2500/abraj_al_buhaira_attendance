part of 'save_attendance_cubit.dart';

@immutable
abstract class SaveAttendanceState {}

class SaveAttendanceInitial extends SaveAttendanceState {}

class SaveAttendanceLoadingState extends SaveAttendanceState{}
class SaveAttendanceSuccessState extends SaveAttendanceState{
  final  attendanceData ;
  SaveAttendanceSuccessState({required this.attendanceData});
}
class SaveAttendanceErrorState extends SaveAttendanceState{

  final String errorMessage;
  final bool logout;

  SaveAttendanceErrorState({required this.errorMessage,required this.logout});
}

