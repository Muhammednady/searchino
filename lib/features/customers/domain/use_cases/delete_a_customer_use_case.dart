

import 'package:dartz/dartz.dart';
import 'package:searchino/features/customers/domain/repository/customers_repo.dart';

import '../../../../core/error/failures.dart';

class DeleteACustomerUseCase{
  final CustomersRepository deleteACustomer;

  DeleteACustomerUseCase({required this.deleteACustomer});
  Future<Either<Failure, Unit>> call(String customerID){
    return deleteACustomer.deleteACustomer(customerID);
  }
}