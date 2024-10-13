
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/profile/profile_state.dart';

import '../../repositories/guest_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitialProfileState());

  GuestRepository guestRepository = GuestRepository();

  void getProfile() async {
    emit(LoadingProfileState());

    // await Future.delayed(Duration(seconds: 3));

    guestRepository.me().then((resp) async {
      emit(SuccessProfileState(resp));
    });
  }
}
