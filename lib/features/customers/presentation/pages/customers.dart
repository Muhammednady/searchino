import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/core/search_widget.dart';
import 'package:searchino/core/util/snackbar_message.dart';
import 'package:searchino/core/widgets.dart';
import 'package:searchino/features/customers/presentation/cubit/customers/customers_cubit.dart';
import 'package:searchino/features/customers/presentation/pages/add_update.dart';
import 'package:searchino/features/customers/presentation/widgets/customers_page/customers_list_widget.dart';
import 'package:searchino/features/customers/presentation/widgets/message_display_widget.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchData(
                        customers: CustomersCubit.get(context).customers!));
              },
              icon: const Icon(
                Icons.search,
                size: 30.0,
              ))
        ],
      ),
      floatingActionButton: _buildFAbtn(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<CustomersCubit, CustomersStates>(
      listener: (context, state) {
        //will be used with Delete State
        if (state is CustomerDeleteErrorstate) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        } else if (state is CustomerDeleteSuccessstate) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        var cubit = CustomersCubit.get(context);

        if (state is CustomersLoadingState) {
          return const LoadingWidget();
        } else if (state is CustomersErrorState) {
          return MessageDisplayWidget(message: state.message);
        }
        if(state is CustomersSuccessState){
          return RefreshIndicator(
            onRefresh: () => _onFresh(),
            child: CustomersListWidget(customers: state.customers));
        }
        return SizedBox();
      },
    );
  }

  Future<void> _onFresh() async {
    //  CustomersCubit.get(context).getAllCustomers();
  }

  Widget _buildFAbtn(context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //Navigate to Add Page
          //AnimatedTransition
          navigateToAndRemove(AddOrUpdatePage(isUpdate: false), context);
        });
  }
}
