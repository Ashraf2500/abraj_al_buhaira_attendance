part of 'get_locations_cubit.dart';

@immutable
abstract class GetLocationsState {}

class GetLocationsInitial extends GetLocationsState {}

class GetLocationsLoadingState extends GetLocationsState{}
class GetLocationsSuccessState extends GetLocationsState{
  final GetLocationsModel getLocationsData ;
  GetLocationsSuccessState({required this.getLocationsData});
}
class GetLocationsErrorState extends GetLocationsState{

  final String errorMessage;
  final bool logout;
  final bool tryAgain;

  GetLocationsErrorState({required this.errorMessage,required this.logout,required this.tryAgain});
}