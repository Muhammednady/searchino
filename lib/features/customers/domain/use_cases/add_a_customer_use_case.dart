import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:searchino/core/error/failures.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/domain/repository/customers_repo.dart';

class AddCustomerUseCase {
  final CustomersRepository addACustomer;

  AddCustomerUseCase(this.addACustomer);

  Future<Either<Failure, Unit>> call(Customer customer , File image) {
    return addACustomer.addACustomer(customer,image);
  }
}

// File? image;
// Future pickImage() async {

//   final images = await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (images == null){
//   final image = File(images!.path);
//   }
// }
