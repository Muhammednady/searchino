import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/core/util/snackbar_message.dart';
import 'package:searchino/core/widgets.dart';
import 'package:searchino/features/customers/presentation/cubit/AddOrUpdateOrDelete/add_or_update_or_delete_cubit.dart';
import 'package:searchino/features/customers/presentation/pages/add_update.dart';
import 'package:searchino/features/customers/presentation/pages/customers.dart';
import 'package:searchino/features/customers/presentation/widgets/alert_loading.dart';

import '../../domain/entity/customer_entity.dart';

class DetailsPage extends StatelessWidget {
  final Customer customer;
  const DetailsPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(top: 10.0,start: 10.0,end: 10.0),
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(customer.imageUrl!))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              customer.name,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black,fontSize: 20.0),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              customer.company,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              customer.phone,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      navigateToAndSave(
                          AddOrUpdatePage(
                            isUpdate: true,
                            customer: customer,
                          ),
                          context);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: const Text('Edit')),
                ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocConsumer<AddOrUpdateOrDeleteCubit,
                              AddOrUpdateOrDeleteStates>(
                            listener: (context, state) {
                              if (state is AddOrUpdateOrDeleteSuccessState) {
                                SnackBarMessage().showSuccessSnackBar(
                                    message: state.message, context: context);
                                navigateToAndRemove(
                                    const CustomersPage(), context);
                              } else if (state
                                  is AddOrUpdateOrDeleteErrorState) {
                                SnackBarMessage().showErrorSnackBar(
                                    message: state.message, context: context);
                                Navigator.of(context).pop();
                              }
                            },
                            builder: (context, state) {
                              if (state is AddOrUpdateOrDeleteLoadingState) {
                                return const AlertLoading();
                              }
                              return AlertDialog(
                                title: const Text('Are you sure ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        AddOrUpdateOrDeleteCubit.get(context)
                                            .deleteCustomer(customer.id!);
                                      },
                                      child: const Text('Yes')),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                    label: const Text('Delete'))
              ],
            )
          
          ],
        ),
      ),
    );
  }
}
