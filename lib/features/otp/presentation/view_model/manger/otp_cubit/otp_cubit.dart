import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  late String verificationId;
  OtpCubit() : super(OtpInitial());

  Future<void> submitPhoneNumber (String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: codeSent,
      codeAutoRetrievalTimeout:codeAutoRetrievalTimeout ,
    );
  }
  Future<void> verificationCompleted(PhoneAuthCredential credential) async {
    print('verification completed');
    await signIn (credential);
  }
  void verificationFailed (FirebaseAuthException error){
    print('error failed ${error.toString()}');
    emit(ErrorOccurred(errorMessage: error.toString())) ;
  }
  void codeSent (String verificationId, int? resendToken){
    print('codeSent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }
  void codeAutoRetrievalTimeout (String verificationId) {
    print('codeAutoRetrievalTimeout');
  }
  Future<void> submitOtp (String otpCode)async {
    PhoneAuthCredential  credential = PhoneAuthProvider.credential(verificationId:this.verificationId, smsCode: otpCode);
    await signIn (credential);
  }
  Future <void> signIn (PhoneAuthCredential credential)async {
    try{
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpVerified());
    }catch (error){
      emit(ErrorOccurred(errorMessage: error.toString()));
    }
  }
  Future<void> logOut()async {
    await FirebaseAuth.instance.signOut();
  }
  User getLogedInUser(){
    User fireBaseUser = FirebaseAuth.instance.currentUser!;
    return fireBaseUser;
  }
}
