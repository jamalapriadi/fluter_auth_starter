import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/login/login_state.dart';

import '../../models/login/login_request.dart';
import '../../repositories/guest_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  GuestRepository guestRepository = GuestRepository();

  void login(String username, String password) async {
    emit(LoadingLoginState());

    await Future.delayed(const Duration(seconds: 3));

    LoginRequest loginRequest =
        LoginRequest(email: username, password: password);

    guestRepository.login(loginRequest).then((resp) async {
      if (resp.success == true) {
        guestRepository.checkLoginStatus(true);
        guestRepository.updateLoggedInStatus(resp.accessToken.toString());
        guestRepository.updateName(resp.name.toString());
        guestRepository.updateEmail(resp.email.toString());
        emit(SuccessLoginState(resp.status.toString()));
      } else {
        emit(FailureLoginState(resp.message.toString()));
      }
    });
  }

  void checkIfLoggedIn() async {
    final isLogin = await guestRepository.cekIsLogin();

    if (isLogin == true) {
      //check if token expired or not
      emit(CekLoginStatusState());
      guestRepository.me().then((resp) async {
        if (resp.succes == true) {
          emit(AvailableAuthState());
        } else {
          emit(FailureLoginState('Login Gagal'));
        }
      });
    } else {
      emit(FailureLoginState('Login Gagal'));
    }
  }

  void logout() async {
    await guestRepository.signOut();

    emit(FailureLoginState('Logout Berhasil'));
  }
}
