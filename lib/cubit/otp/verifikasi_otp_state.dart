import 'package:equatable/equatable.dart';

import '../../models/otp/verifikasi_otp_response.dart';

abstract class VerifikasiOtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialVerifikasiOtpState extends VerifikasiOtpState {}

class LoadingVerifikasiOtpState extends VerifikasiOtpState {}

class FailureVerifikasiOtpState extends VerifikasiOtpState {
  final String errorMessage;

  FailureVerifikasiOtpState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureVerifikasiOtpState{errorMessage: $errorMessage}';
  }
}

class SuccessVerifikasiOtpState extends VerifikasiOtpState {
  final VerifikasiOtpResponse listVerifikasiOtp;

  SuccessVerifikasiOtpState(this.listVerifikasiOtp);

  @override
  String toString() {
    return 'SuccessVerifikasiOtpState{listVerifikasiOtp: $listVerifikasiOtp}';
  }
}
