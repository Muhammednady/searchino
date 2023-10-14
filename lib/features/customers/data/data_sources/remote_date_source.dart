import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:searchino/core/error/exceptions.dart';
import 'package:searchino/features/customers/data/model/customer_model.dart';

abstract class CustomersRemoteDataSource {
  Future<List<CustomerModel>> getAllCustomers();

  Future<Unit> addACustomer(CustomerModel customer, File image);

  Future<Unit> updateACustomer(CustomerModel customer, {File? image});

  Future<Unit> deleteACustomer(String CustomerID);
}

class CustomersRemoteDataSourceImpl extends CustomersRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  CustomersRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});

  @override
  Future<List<CustomerModel>> getAllCustomers() async {
    List<CustomerModel> customers = [];

    firebaseFirestore.collection('customers').get().then((value) {
      value.docs.forEach((element) {
        customers
            .add(CustomerModel.formJson(element.data())..setID = element.id);
      });
    }).catchError((error) {
      throw ServerException();
    });

    return customers;
  }

  Future<String> uploadImage(File image) async {
   // String? imageUrl;
    int imagenum = Random().nextInt(1000);
    String imageName = Uri.file(image.path).pathSegments.last;
    return firebaseStorage
        .ref()
        .child('images/$imagenum$imageName')
        .putFile(image)
        .then((p0) {
     return p0.ref.getDownloadURL().then((value) {
        print('==========value==============');
        print(value);
        print('========================');
        return value;
      }).catchError((error) {
        throw ServerException();
      });
    }).catchError((error) {
      throw ServerException();
    });
    // print('==========imageUrl==============');
    // print(imageUrl);
    // print('========================');

    // return imageUrl;
  }

  @override
  Future<Unit> addACustomer(CustomerModel customer, File image) async {
    // uploadImage(image).then((value) {
    //   firebaseFirestore
    //       .collection('customers')
    //       .add(CustomerModel(
    //               name: customer.name,
    //               phone: customer.phone,
    //               company: customer.company,
    //               imageUrl: value)
    //           .toJson())
    //       .then((value) {
    //     return Future.value(unit);
    //   }).catchError((error) {
    //     throw ServerException();
    //   });
    // }).catchError((error) {
    //   throw ServerException();
    // });
    try {
      String imageUrl = await uploadImage(image);
      //if there is a problem use then&catchError
      await firebaseFirestore.collection('customers').add(CustomerModel(
              name: customer.name,
              phone: customer.phone,
              company: customer.company,
              imageUrl: imageUrl)
          .toJson());
    } on Exception {
      throw ServerException();
    }
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteACustomer(String CustomerID) async {
    try {
      await firebaseFirestore.collection('customers').doc(CustomerID).delete();
    } catch (error) {
      throw ServerException();
    }

    return Future.value(unit);
  }

  @override
  Future<Unit> updateACustomer(CustomerModel customer, {File? image}) async {
    String imageUrl = '';

    if (image != null) {
      try {
        imageUrl = await uploadImage(image);
        //if there is a problem use then&catchError
        await firebaseFirestore.collection('customers').doc(customer.id).update(
            CustomerModel(
                    name: customer.name,
                    phone: customer.phone,
                    company: customer.company,
                    imageUrl: imageUrl)
                .toJson());
      } on Exception {
        throw ServerException();
      }
    } else {
      try {
        await firebaseFirestore
            .collection('customers')
            .doc(customer.id)
            .set(customer.toJson());
      } on Exception {
        throw ServerException();
      }
    }

    return Future.value(unit);
  }
}
