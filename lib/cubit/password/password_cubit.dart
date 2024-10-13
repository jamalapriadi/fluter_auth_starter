import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/password/password_state.dart';
import '../../models/password/password_request.dart';
import '../../repositories/guest_repository.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(InitialPasswordState());

  GuestRepository guestRepository = GuestRepository();

  void forgotPassword(String email) async {
    emit(LoadingPasswordState());

    await Future.delayed(const Duration(seconds: 3));

    PasswordRequest passwordRequest = PasswordRequest(email: email);

    guestRepository.forgot(passwordRequest).then((resp) async {
      if (resp.success == true) {
        emit(SuccessPasswordState());
      } else {
        emit(FailurePasswordState(resp.message.toString()));
      }
    });
  }
}
