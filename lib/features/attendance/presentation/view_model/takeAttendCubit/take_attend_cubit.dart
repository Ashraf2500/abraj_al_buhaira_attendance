import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../features_exports.dart';

part 'take_attend_state.dart';


List<EmployeeAttendModel> listOfEmployeeAttend = [];
class TakeAttendCubit extends Cubit<TakeAttendState> {
  TakeAttendCubit() : super(TakeAttendInitial());

  takeAttendEmployee(EmployeeAttendModel employeeAttendModel){
      (listOfEmployeeAttend.add(employeeAttendModel));

      emit(TakeAttendEmployeeState(employeeAttendModel));
  }

  RemoveAttendEmployee(EmployeeAttendModel employeeAttendModel){
    (listOfEmployeeAttend.remove(employeeAttendModel));

    emit(RemoveAttendEmployeeState(employeeAttendModel));
  }
}
