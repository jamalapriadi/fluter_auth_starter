import 'package:equatable/equatable.dart';

import '../../models/profile/update_password_response.dart';

class UpdatePasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialUpdatePasswordState extends UpdatePasswordState {}

class LoadingUpdatePasswordState extends UpdatePasswordState {}

class FailureUpdatePasswordState extends UpdatePasswordState {
  final String errorMessage;

  FailureUpdatePasswordState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailurePasswordState{errorMessage: $errorMessage}';
  }
}

class SuccessUpdatePasswordState extends UpdatePasswordState {
  final UpdatePasswordResponse listPassword;

  SuccessUpdatePasswordState(this.listPassword);

  @override
  String toString() {
    return 'SuccessUpdatePasswordState{listPassword: $listPassword}';
  }
}
