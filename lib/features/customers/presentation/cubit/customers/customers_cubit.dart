import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/core/error/failures.dart';
import 'package:searchino/core/strings/failures.dart';
import 'package:searchino/core/strings/messages.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/domain/use_cases/delete_a_customer_use_case.dart';
import 'package:searchino/features/customers/domain/use_cases/get_all_customers_use_case.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersStates> {
  final GetAllCustomersUseCase getUseCase;
  final DeleteACustomerUseCase deleteACustomerUseCase;
  CustomersCubit(
      {required this.deleteACustomerUseCase, required this.getUseCase})
      : super(CustomersInitialState());
  List<Customer>? customers;
  static CustomersCubit get(context) => BlocProvider.of(context);

  void getAllCustomers() async{
    emit(CustomersLoadingState());
    // var res = await getUseCase.call();
    // res.fold(
    //   (l) => emit,
    //    (r) => null
    //    );
    getUseCase.call().then((value) {
      emit(mapEitherTOSuccessOrError(value));
    }).catchError((error) {});
    emit(CustomersGetConfirmationState());
  }

  CustomersStates mapEitherTOSuccessOrError(
      Either<List<Customer>, Failure> either) {
    return either.fold((customers) {
      this.customers = customers;
      return CustomersSuccessState(customers: customers);
    }, (failure) {
      return CustomersErrorState(message: _mapFailureToMessage(failure));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      default:
        return UNKNOWN_FAILURE;
    }
  }

  void deleteCustomer(Customer customer) async{

   var failureOrUnit = await deleteACustomerUseCase.call(customer.id!);
   failureOrUnit.fold(
    (failure) => emit(CustomerDeleteErrorstate(message: _mapFailureToMessage(failure))) ,
    (_) {
      customers!.remove(customer);
      return emit(const CustomerDeleteSuccessstate(message:DELETE_SUCCESS_MESSAGE ));
    },
     );

    
  }
}
