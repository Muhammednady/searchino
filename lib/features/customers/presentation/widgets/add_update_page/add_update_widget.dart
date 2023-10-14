import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:searchino/core/app_theme.dart';
import 'package:searchino/core/widgets.dart';
import 'package:searchino/features/customers/domain/entity/customer_entity.dart';
import 'package:searchino/features/customers/presentation/cubit/AddOrUpdateOrDelete/add_or_update_or_delete_cubit.dart';

// ignore: must_be_immutable
class AddOrUpdateWidget extends StatefulWidget {
  final bool isUpdate;
  Customer? customer;
  AddOrUpdateOrDeleteStates state;
  AddOrUpdateWidget(
      {super.key, required this.isUpdate, this.customer, required this.state});

  @override
  State<AddOrUpdateWidget> createState() => _AddOrUpdateWidgetState();
}

class _AddOrUpdateWidgetState extends State<AddOrUpdateWidget> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var companyController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      nameController.text = widget.customer!.name;
      phoneController.text = widget.customer!.phone;
      companyController.text = widget.customer!.company;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.state is AddOrUpdateOrDeleteLoadingState)
                const LinearProgressIndicator(
                  backgroundColor: primaryColor,
                 // color: Colors.red,
                ),
              if (widget.state is AddOrUpdateOrDeleteLoadingState)
                const SizedBox(
                  height: 10,
                ),
              DefaultTextFormField(
                  label: 'name',
                  type: TextInputType.name,
                  controll: nameController,
                  prefix: Icons.person_2_outlined,
                  validate: (value) =>
                      value!.isEmpty ? 'Name can\'t be empty' : null),
              const SizedBox(
                height: 15,
              ),
              DefaultTextFormField(
                  label: 'phone',
                  type: TextInputType.number,
                  controll: phoneController,
                  prefix: Icons.phone_android,
                  validate: (value) =>
                      value!.isEmpty ? 'Phone can\'t be empty' : null),
              const SizedBox(
                height: 15,
              ),
              DefaultTextFormField(
                  label: 'company',
                  type: TextInputType.name,
                  controll: companyController,
                  prefix: Icons.business,
                  validate: (value) =>
                      value!.isEmpty ? 'company can\'t be empty' : null),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: defaultButton(context, onpressed: () {
                  AddOrUpdateOrDeleteCubit.get(context).showBottom(context);
                }, text: 'add image'),
              ),
              const SizedBox(
                height: 15,
              ),
              defaultButton(context,
                  onpressed: () => checkOutAndConfirm(context),
                  text: widget.isUpdate ? 'update customer' : 'add customer',
                  isUppercase: true),
            ],
          ),
        ),
      ),
    );
  }

  void checkOutAndConfirm(context) {
    var cubit = AddOrUpdateOrDeleteCubit.get(context);

    if (formKey.currentState!.validate()) {
      if (!widget.isUpdate) {
        if (cubit.image != null) {
          cubit.addCustomer(
              Customer(
                name: nameController.text,
                phone: phoneController.text,
                company: companyController.text,
              ),
              cubit.image!);
        } else {
          AwesomeDialog(
                  context: context,
                  padding:const EdgeInsets.all(20.0),
                  dialogBackgroundColor: primaryColor,
                  dialogType: DialogType.info,
                  title: 'Please,choose an image')
              .show();
        }
      } else {
        if (cubit.image != null) {
          cubit.updateCustomer(
              Customer(
                  name: nameController.text,
                  phone: phoneController.text,
                  company: companyController.text,
                  id: widget.customer!.id),
              image: cubit.image);
        } else {
          cubit.updateCustomer(Customer(
              name: nameController.text,
              phone: phoneController.text,
              company: companyController.text,
              id: widget.customer!.id,
              imageUrl: widget.customer!.imageUrl!));
        }
      }
    }
  }
  @override
  void dispose() {
    
    super.dispose();
    //CustomersCubit.get(context).getAllCustomers();
  }




}
