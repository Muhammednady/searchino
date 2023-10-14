import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/core/util/snackbar_message.dart';
import 'package:searchino/core/widgets.dart';
import 'package:searchino/features/auth/sign_up/cubit/cubit/register_cubit.dart';
import 'package:searchino/features/customers/presentation/pages/customers.dart';

// ignore: must_be_immutable
class RegisterSCreen extends StatelessWidget {
  RegisterSCreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(body: _buildBody()),
    );
  }

  _buildBody() {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is AddCustomerDataErrorState){
          SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
        }
        if(state is RegisterErrorState){
          SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
        }
        if(state is RegisterSuccessState){
          navigateToAndRemove(const CustomersPage(), context);
        }
      },
      builder: (context, state) {
        var cubit  = RegisterCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultCustomerImage('customer.jpg'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'register'.toUpperCase(),
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
                        label: 'Name',
                        type: TextInputType.name,
                        controll: nameController,
                        prefix: Icons.person_2_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please , Enter your name ';
                          }
                          return null;
                        }),
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
                        isPassword:cubit.isPassword,
                        prefix: cubit.prefixIcon,
                        suffix: cubit.suffixIcon,
                        onSubmit: (value) {
                          cubit.register(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            bio: bioController.text,
                          );
                        },
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
                      height: 20.0,
                    ),
                    DefaultTextFormField(
                        label: 'Phone',
                        type: TextInputType.phone,
                        controll: phoneController,
                        prefix: Icons.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please , Enter your phone ';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultTextFormField(
                        label: 'Write your Bio',
                        type: TextInputType.text,
                        controll: bioController,
                        prefix: Icons.biotech,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please , Write your Bio ';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    state is RegisterLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        :
                    defaultButton(context, onpressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.register(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                        );
                      }
                    }, color: Colors.teal, isUppercase: true, text: 'Register'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
