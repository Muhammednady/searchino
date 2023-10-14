import 'package:flutter/material.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/presentation/widgets/customers_page/customers_list_widget.dart';

class SearchData extends SearchDelegate {
  final List<Customer> customers;

  SearchData({required this.customers});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, 8);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Customer> filterCustomers =
        customers.where((element) => element.name.contains(query)).toList();

    return CustomersListWidget(
        customers: query == "" ? customers : filterCustomers);
  }
}
