import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPasswordState extends PasswordState {}

class LoadingPasswordState extends PasswordState {}

class FailurePasswordState extends PasswordState {
  final String errorMessage;

  FailurePasswordState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailurePasswordState{errorMessage: $errorMessage}';
  }
}

class SuccessPasswordState extends PasswordState {}
