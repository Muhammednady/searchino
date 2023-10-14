/*
.....
Program to an abstraction(interface) not to implementation
......
*/

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:searchino/core/error/failures.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';

abstract class CustomersRepository {

  Future<Either<List<Customer>, Failure>> getAllCustomers();

  Future<Either<Failure, Unit>> addACustomer(Customer customer,File image);

  Future<Either<Failure, Unit>> updateACustomer(Customer customer,{File? image});

  Future<Either<Failure, Unit>> deleteACustomer(String customerID);
}
