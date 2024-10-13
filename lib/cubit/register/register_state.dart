import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class FailureRegisterState extends RegisterState {
  final String errorMessage;

  FailureRegisterState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureRegisterState{errorMessage: $errorMessage}';
  }
}

class SuccessRegisterState extends RegisterState {}
