import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:searchino/core/error/failures.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/domain/repository/customers_repo.dart';

class UpdateCustomerUseCase {
  final CustomersRepository updateACustomer;

  UpdateCustomerUseCase(this.updateACustomer);

  Future<Either<Failure, Unit>> call(Customer customer , {File? image}) {
    if(image != null){
    return updateACustomer.updateACustomer(customer,image:image);

    }else{
    return updateACustomer.updateACustomer(customer);

    }
  }
}


/*
so important note ----
Don't ever pass null as an arugment to a function
------------
*/