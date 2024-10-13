import 'package:equatable/equatable.dart';

class UpdateFotoState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialUpdateFotoState extends UpdateFotoState {}

class LoadingUpdateFotoState extends UpdateFotoState {}

class FailureUpdateFotoState extends UpdateFotoState {
  final String errorMessage;

  FailureUpdateFotoState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureProfileState{errorMessage: $errorMessage}';
  }
}

class SuccessUpdateFotoState extends UpdateFotoState {
  final String errorMessage;

  SuccessUpdateFotoState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'Update Foto Berhasil';
  }
}
