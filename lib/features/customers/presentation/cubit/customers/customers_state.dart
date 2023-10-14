part of 'customers_cubit.dart';

sealed class CustomersStates extends Equatable {
  const CustomersStates();

  @override
  List<Object> get props => [];
}

final class CustomersInitialState extends CustomersStates {}
final class CustomersLoadingState extends CustomersStates {}

 // ignore: must_be_immutable
 class CustomersSuccessState extends CustomersStates {
 final List<Customer> customers;
 const  CustomersSuccessState({required this.customers});
}

final class CustomersErrorState extends CustomersStates {
  final String message;

  const CustomersErrorState({required this.message});
}

final class CustomerDeleteSuccessstate extends CustomersStates{
  final String message;

 const CustomerDeleteSuccessstate({required this.message});
  
}

final class CustomerDeleteErrorstate extends CustomersStates{
  final String message;

 const CustomerDeleteErrorstate({required this.message});
  
}

final class CustomersGetConfirmationState extends CustomersStates {}
