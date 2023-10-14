import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/features/auth/sign_up/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData prefixIcon = Icons.lock_outline;
  IconData suffixIcon = Icons.visibility;

  void changePasswordState() {
    isPassword = !isPassword;
    prefixIcon = isPassword ? Icons.lock_outline : Icons.lock_open;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordState());
  }

  void register(
      {required String name,
      required String phone,
      required String bio,
      required String email,
      required String password}) async {
    emit(RegisterLoadingState());

    UserModel userModel = UserModel(name: name, phone: phone, bio: bio);
    FirebaseFirestore.instance
        .collection('users')
        .add(userModel.toJson())
        .then((value) async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        emit(RegisterSuccessState());
      } catch(exception) {
         FirebaseAuthException messageException =
           exception as FirebaseAuthException;
            emit(RegisterErrorState(message: messageException.message!));
      }

      //     FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password)
      //     .then((value) {
      //   emit(RegisterSuccessState());
      // }).catchError((exception) {
      //   // FirebaseAuthException messageException =
      //   //     exception as FirebaseAuthException;
      //   emit(RegisterErrorState(message: exception.toString()));
      // });
    }).catchError((error) {
      emit(const AddCustomerDataErrorState('Error: please try again later'));
    });
  }
}
