import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitialState());
  static LogInCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData prefixIcon = Icons.lock_outline;
  IconData suffixIcon = Icons.visibility;

  void changePasswordState() {
    isPassword = !isPassword;
    prefixIcon = isPassword ? Icons.lock_outline : Icons.lock_open;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordState());
  }

  void logIn({required String email, required String password}) {
    emit(LogInLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LogInSuccessState());
    }).catchError((exception) {
      FirebaseAuthException messageException =
          exception as FirebaseAuthException;
      emit(LogInErrorState(message: messageException.message!));
    });
    // try{

    // }on FirebaseAuthException{

    // }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signInWithGmail() async {
    signInWithGoogle().then((value) {
      emit(LogInSuccessState());
    }).catchError((error) {
      print('==================================');
      print(error);
      var exception = error as FirebaseAuthException;

      emit(LogInErrorState(message: exception.message!));
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  void logInwithFacebook() async {
    signInWithFacebook().then((value) {
      emit(LogInSuccessState());
    }).catchError((error) {
      error as FirebaseAuthException;

      emit(LogInErrorState(message: error.message!));
    });
  }
}
