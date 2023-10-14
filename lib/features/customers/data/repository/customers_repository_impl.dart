import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:searchino/core/error/exceptions.dart';
import 'package:searchino/core/error/failures.dart';
import 'package:searchino/core/network/network_info.dart';
import 'package:searchino/features/customers/data/data_sources/local_data_source.dart';
import 'package:searchino/features/customers/data/data_sources/remote_date_source.dart';
import 'package:searchino/features/customers/data/model/customer_model.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/domain/repository/customers_repo.dart';

class CustomersRepositoryImpl extends CustomersRepository {
  final CustomersRemoteDataSource remoteDataSource;
  final CustomersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CustomersRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<List<Customer>, Failure>> getAllCustomers() async {
    List<CustomerModel> customers;
    if (await networkInfo.isConnected) {
      try {
        customers = await remoteDataSource.getAllCustomers();
        localDataSource.cacheCustomers(customers);
      } on ServerException {
        return right(ServerFailure());
      }
    } else {
      try {
        customers = localDataSource.getCachedCustomers();
      } catch (error) {
        return right(EmptyCacheFailure());
      }
    }
    return left(customers);
  }

  @override
  Future<Either<Failure, Unit>> addACustomer(
      Customer customer, File image) async {
    if (await networkInfo.isConnected) {
      remoteDataSource.addACustomer(
          CustomerModel.nullImage(
              id: customer.id,
              name: customer.name,
              phone: customer.phone,
              company: customer.company),
          image);
    } else {
      return left(OfflineFailure());
    }
    return right(unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteACustomer(String customerID) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.deleteACustomer(customerID);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
    return right(unit);
  }

  @override
  Future<Either<Failure, Unit>> updateACustomer(Customer customer,
      {File? image}) async {
    if (await networkInfo.isConnected) {
      try {
        if (image != null) {
          remoteDataSource.updateACustomer(
              CustomerModel.nullImage(
                  name: customer.name,
                  phone: customer.phone,
                  company: customer.company,
                  id: customer.id),
              image: image);
        } else {
          remoteDataSource.updateACustomer(CustomerModel(
              name: customer.name,
              phone: customer.phone,
              company: customer.company,
              imageUrl: customer.imageUrl)
            ..setID = customer.id!);
        }
      } catch (error) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
    return right(unit);
  }
}
