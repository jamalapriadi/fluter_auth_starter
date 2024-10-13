import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/profile/update_password_request.dart';
import '../../repositories/guest_repository.dart';
import 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(InitialUpdatePasswordState());

  GuestRepository guestRepository = GuestRepository();

  void updatePassword(
      String current, String password, String passwordConfirmation) async {
    emit(LoadingUpdatePasswordState());

    await Future.delayed(const Duration(seconds: 3));

    UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
        current: current,
        password: password,
        passwordConfirmation: passwordConfirmation);

    guestRepository.updatePassword(updatePasswordRequest).then((resp) async {
      if (resp.success == true) {
        emit(SuccessUpdatePasswordState(resp));
      } else {
        emit(FailureUpdatePasswordState(resp.message.toString()));
      }
    });
  }
}
