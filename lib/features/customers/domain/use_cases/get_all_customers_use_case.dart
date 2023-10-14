
import 'package:dartz/dartz.dart';
import 'package:searchino/core/error/failures.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/domain/repository/customers_repo.dart';

class GetAllCustomersUseCase{
  final CustomersRepository getAllCustomers;

  GetAllCustomersUseCase( this.getAllCustomers);

  Future<Either<List<Customer>, Failure>> call(){
    
    return getAllCustomers.getAllCustomers();
  }
}