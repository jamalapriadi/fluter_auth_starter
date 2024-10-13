import 'package:equatable/equatable.dart';

import '../../models/user/profile_response.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class FailureProfileState extends ProfileState {
  final String errorMessage;

  FailureProfileState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureProfileState{errorMessage: $errorMessage}';
  }
}

class SuccessProfileState extends ProfileState {
  final ProfileResponse listProfile;

  SuccessProfileState(this.listProfile);

  @override
  String toString() {
    return 'SuccessProfileState{listProfile: $listProfile}';
  }
}
