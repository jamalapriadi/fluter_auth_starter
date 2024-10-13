import 'package:equatable/equatable.dart';

import '../../models/profile/update_profile_response.dart';

class UpdateProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialUpdateProfileState extends UpdateProfileState {}

class LoadingUpdateProfileState extends UpdateProfileState {}

class FailureUpdateProfileState extends UpdateProfileState {
  final String errorMessage;

  FailureUpdateProfileState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureProfileState{errorMessage: $errorMessage}';
  }
}

class SuccessUpdateProfileState extends UpdateProfileState {
  final UpdateProfileResponse listProfile;

  SuccessUpdateProfileState(this.listProfile);

  @override
  String toString() {
    return 'SuccessUpdateProfileState{listProfile: $listProfile}';
  }
}
