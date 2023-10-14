part of 'log_in_cubit.dart';

sealed class LogInStates extends Equatable {
  const LogInStates();

  @override
  List<Object> get props => [];
}

final class LogInInitialState extends LogInStates {}

final class LogInLoadingState extends LogInStates {}

final class LogInSuccessState extends LogInStates {}

final class LogInErrorState extends LogInStates {
  final String message;
  const LogInErrorState({required this.message});
}

final class ChangePasswordState extends LogInStates {}
