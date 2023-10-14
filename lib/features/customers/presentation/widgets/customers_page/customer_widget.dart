import 'package:flutter/material.dart';
import 'package:searchino/core/app_theme.dart';
import 'package:searchino/core/widgets.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/presentation/cubit/customers/customers_cubit.dart';
import 'package:searchino/features/customers/presentation/pages/add_update.dart';
import 'package:searchino/features/customers/presentation/pages/details_page.dart';

class CustomerWidget extends StatelessWidget {
  final Customer customer;

  const CustomerWidget({super.key, required this.customer});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToAndSave(DetailsPage(customer: customer), context);
      },
      child: Dismissible(
        key: Key('${customer.id}'),
        onDismissed: (direction) {
          CustomersCubit.get(context).deleteCustomer(customer);
        },
        child: Row(
          children: [
            Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(customer.imageUrl!))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    customer.company,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    customer.phone,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  // navigate to Update Page
                  navigateToAndSave(
                      AddOrUpdatePage(
                        isUpdate: true,
                        customer: customer,
                      ),
                      context);
                },
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                  color: primaryColor,
                ))
          ],
        ),
      ),
    );
  }
}
