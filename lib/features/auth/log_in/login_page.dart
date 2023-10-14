import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/core/app_theme.dart';
import 'package:searchino/core/strings/images_names.dart';
import 'package:searchino/core/widgets.dart';
import 'package:searchino/features/auth/log_in/cubit/login/log_in_cubit.dart';
import 'package:searchino/features/auth/log_in/widgets/signin_account_widget.dart';
import 'package:searchino/features/auth/sign_up/signup_page.dart';
import 'package:searchino/features/customers/presentation/pages/customers.dart';

class LogInSCreen extends StatelessWidget {
  LogInSCreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: Scaffold(key: scaffoldKey, body: _buildBody(context)),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocConsumer<LogInCubit, LogInStates>(
        listener: (context, state) {
          if (state is LogInErrorState) {
            //show Error message
            showToast(state.message, ToastStates.ERROR);
            //also SnackBar can be used
          }
          if (state is LogInSuccessState) {
            //navigaTe to main Page
            showToast('succeeded SignIn Process', ToastStates.SUCCESS);

             navigateToAndRemove(const CustomersPage(), context);
          }
        },
        builder: (context, state) {
          LogInCubit cubit = LogInCubit.get(context);
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultCustomerImage(CUSTOMER_IMAGE),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'LOG IN',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultTextFormField(
                        label: 'Email Address',
                        type: TextInputType.emailAddress,
                        controll: emailController,
                        prefix: Icons.email_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please , Enter your email address ';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultTextFormField(
                        label: 'password',
                        type: TextInputType.visiblePassword,
                        controll: passwordController,
                        isPassword: cubit.isPassword,
                        prefix: cubit.prefixIcon,
                        suffix: cubit.suffixIcon,
                        suffixpressed: () {
                          cubit.changePasswordState();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password can\'t be empty ';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    state is LogInLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : defaultButton(context, onpressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.logIn(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                            color: primaryColor,
                            isUppercase: true,
                            text: 'log in'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        // SizedBox(width: 5.0,),
                        defaultTextButton(context, text: 'register',
                            onAction: () {
                          navigateToAndRemove(RegisterSCreen(), context);
                        })
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 2.0,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'or',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 2.0,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SignInAccountWidget(
                            image: GOOGLE_IMAGE, onAction: () {cubit.signInWithGmail();}),
                        SignInAccountWidget(
                            image: FACEBOOK_IMAGE, onAction: () {cubit.logInwithFacebook();}),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
