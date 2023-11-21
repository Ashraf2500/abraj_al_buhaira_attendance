part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class Loading extends OtpState {}
class ErrorOccurred extends OtpState{
  final String errorMessage ;
  ErrorOccurred({required this.errorMessage});
}

class PhoneNumberSubmitted extends OtpState{}
class PhoneOtpVerified extends OtpState{}