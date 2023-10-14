part of 'register_cubit.dart';

sealed class RegisterStates extends Equatable {
  const RegisterStates();

  @override
  List<Object> get props => [];
}

final class RegisterInitialState extends RegisterStates {}

final class RegisterLoadingState extends RegisterStates {}

final class RegisterSuccessState extends RegisterStates {}

final class RegisterErrorState extends RegisterStates {
  final String message;
  const RegisterErrorState({required this.message});
}

final class ChangePasswordState extends RegisterStates {}
final class AddCustomerDataErrorState extends RegisterStates{
  final String message;

 const AddCustomerDataErrorState(this.message);
  
}