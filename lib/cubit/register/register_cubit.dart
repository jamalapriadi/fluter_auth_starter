import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/register/register_state.dart';
import '../../repositories/guest_repository.dart';

import '../../models/register/register_request.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());

  GuestRepository guestRepository = GuestRepository();

  void register(String name, String email, String password,
      String phone) async {
    emit(LoadingRegisterState());

    await Future.delayed(const Duration(seconds: 3));

    RegisterRequest registerRequest = RegisterRequest(
        email: email,
        password: password,
        name: name,
        phone: phone,);

    guestRepository.register(registerRequest).then((resp) async {
      if (resp.success == true) {
        emit(SuccessRegisterState());
      } else {
        emit(FailureRegisterState(resp.message.toString()));
      }
    });
  }
}
