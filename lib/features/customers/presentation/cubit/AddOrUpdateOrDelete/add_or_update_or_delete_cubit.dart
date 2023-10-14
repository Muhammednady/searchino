import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchino/core/error/failures.dart';
import 'package:searchino/core/strings/failures.dart';
import 'package:searchino/core/strings/messages.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/domain/use_cases/add_a_customer_use_case.dart';
import 'package:searchino/features/customers/domain/use_cases/delete_a_customer_use_case.dart';
import 'package:searchino/features/customers/domain/use_cases/update_a_customer_use_case.dart';
import 'package:searchino/features/customers/presentation/widgets/image_cature_widget.dart';

part 'add_or_update_or_delete_state.dart';

class AddOrUpdateOrDeleteCubit extends Cubit<AddOrUpdateOrDeleteStates> {
  final AddCustomerUseCase addCustomerUseCase;
  final UpdateCustomerUseCase updateCustomerUseCase;
  final DeleteACustomerUseCase deleteACustomerUseCase;
  AddOrUpdateOrDeleteCubit(
      {required this.addCustomerUseCase,
      required this.updateCustomerUseCase,
      required this.deleteACustomerUseCase})
      : super(AddOrUpdateOrDeleteInitialState());
  File? image;
  static AddOrUpdateOrDeleteCubit get(context) => BlocProvider.of(context);
  void addCustomer(Customer customer, File image) async {
    emit(AddOrUpdateOrDeleteLoadingState());

    var result = await addCustomerUseCase.call(customer, image);
    emit(_mapFailureOrUnitToMessage(result, ADD_SUCCESS_MESSAGE));
    this.image = null;
  }

  void updateCustomer(Customer customer, {File? image}) async {
    emit(AddOrUpdateOrDeleteLoadingState());
    Either<Failure, Unit> result;
    if (image == null) {
      result = await updateCustomerUseCase.call(customer);
    } else {
      result = await updateCustomerUseCase.call(customer, image: image);
    }
    emit(_mapFailureOrUnitToMessage(result, UPDATE_SUCCESS_MESSAGE));
    this.image = null;
  }

  void deleteCustomer(String customerID) async {
    emit(AddOrUpdateOrDeleteLoadingState());

    var result = await deleteACustomerUseCase(customerID);
    emit(_mapFailureOrUnitToMessage(result, DELETE_SUCCESS_MESSAGE));
  }

  AddOrUpdateOrDeleteStates _mapFailureOrUnitToMessage(
      Either<Failure, Unit> result, String message) {
    return result.fold(
        (failure) => AddOrUpdateOrDeleteErrorState(
            message: _mapFailureToMessage(failure)),
        (_) => AddOrUpdateOrDeleteSuccessState(message: message));
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

  void showBottom(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return ImageCaptureWidget(
            onCamera: uploadImageFromCamera,
            onGallery: uploadImageFromGallery,
          );
        }));
  }

  void uploadImageFromCamera() async {
    var imageTaken = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageTaken != null) {
      image = File(imageTaken.path);
    }
       // Navigator.of(context).pop();

  }

  void uploadImageFromGallery() async {
    var imageChosen =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageChosen != null) {
      image = File(imageChosen.path);
    }
   // Navigator.of(context).pop();
  }
}
