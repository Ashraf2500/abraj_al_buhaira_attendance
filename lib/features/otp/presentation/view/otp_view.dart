import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key, required this.phoneNumber}) : super(key: key);
final phoneNumber;
  @override
  Widget build(BuildContext context) {
    return OtpBody(phoneNumber : phoneNumber);
  }
}
