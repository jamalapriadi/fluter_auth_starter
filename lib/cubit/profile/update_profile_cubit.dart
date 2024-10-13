import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/profile/update_profile_state.dart';

import '../../models/profile/update_profile_request.dart';
import '../../repositories/guest_repository.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(InitialUpdateProfileState());

  GuestRepository guestRepository = GuestRepository();

  void updateProfile(UpdateProfileRequest req) async {
    emit(LoadingUpdateProfileState());

    await Future.delayed(const Duration(seconds: 3));


    guestRepository.updateProfile(req).then((resp) async {
      if (resp.success == true) {
        emit(SuccessUpdateProfileState(resp));
      } else {
        emit(FailureUpdateProfileState(resp.message.toString()));
      }
    });
  }
}
