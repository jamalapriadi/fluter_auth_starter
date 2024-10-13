import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/otp/verifikasi_otp_state.dart';

import '../../models/otp/verifikasi_otp_request.dart';
import '../../repositories/guest_repository.dart';

class VerifikasiOtpCubit extends Cubit<VerifikasiOtpState> {
  VerifikasiOtpCubit() : super(InitialVerifikasiOtpState());

  GuestRepository guestRepository = GuestRepository();

  void verifikasi(String email, String otp) async {
    emit(LoadingVerifikasiOtpState());

    await Future.delayed(const Duration(seconds: 3));

    VerifikasiOtpRequest verifikasiOtpRequest =
        VerifikasiOtpRequest(email: email, otp: otp);

    guestRepository.konfirmasiOtp(verifikasiOtpRequest).then((resp) {
      if (resp.success == true) {
        emit(SuccessVerifikasiOtpState(resp));
      } else {
        emit(FailureVerifikasiOtpState(resp.message.toString()));
      }
    });
  }
}
