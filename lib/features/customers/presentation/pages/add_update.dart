import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/core/util/snackbar_message.dart';
import 'package:searchino/core/widgets.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/presentation/cubit/AddOrUpdateOrDelete/add_or_update_or_delete_cubit.dart';
import 'package:searchino/features/customers/presentation/pages/customers.dart';
import 'package:searchino/features/customers/presentation/widgets/add_update_page/add_update_widget.dart';

// ignore: must_be_immutable
class AddOrUpdatePage extends StatelessWidget {
  bool isUpdate;
  Customer? customer;
  AddOrUpdatePage({super.key, required this.isUpdate, this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Customer" : "Add Customer"),
      ),
      body: _buidlBody(),
    );
  }

  Widget _buidlBody() {
    return BlocConsumer<AddOrUpdateOrDeleteCubit, AddOrUpdateOrDeleteStates>(
      listener: (context, state) {
        if (state is AddOrUpdateOrDeleteErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        } else if (state is AddOrUpdateOrDeleteSuccessState) {

          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          navigateToAndRemove(const CustomersPage(), context);
          
        }
      },
      builder: (context, state) {
        return AddOrUpdateWidget(
          state: state,
          isUpdate: isUpdate,
          customer: isUpdate ? customer : null,
        );
      },
    );
  }



}
