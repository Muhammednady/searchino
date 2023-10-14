import 'package:flutter/material.dart';
import 'package:searchino/core/app_theme.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/presentation/widgets/customers_page/customer_widget.dart';

class CustomersListWidget extends StatelessWidget {
  final List<Customer> customers;

  const CustomersListWidget({super.key, required this.customers});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        physics:const BouncingScrollPhysics(),
        itemCount: customers.length,
        itemBuilder: (context, index) =>
            CustomerWidget(customer: customers[index]),
        separatorBuilder: (context, index) => Divider(
          thickness: 1.0,
          color: primaryColor.withOpacity(0.2),
      
        ),
      ),
    );
  }
}
