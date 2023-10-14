import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:searchino/core/app_theme.dart';
//import 'package:fluttertoast/fluttertoast.dart';

void navigateToAndRemove(Widget widget, BuildContext context) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ), (Route route) => false);

void navigateToAndSave(Widget widget, BuildContext context) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ), (Route route) => true);

Widget DefaultCustomerImage(String image)=>Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Image.asset('assets/images/$image'),
                      ),
                    );

Widget DefaultTextFormField({
  String? hintText,
  required String? label,
  required TextInputType type,
  required TextEditingController? controll,
  void Function()? onclicked,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  void Function()? suffixpressed,
  void Function(String)? onSubmit,
  required String? Function(String?) validate,
}) =>
    TextFormField(
      validator: validate,
      controller: controll,
      obscureText: isPassword,
      keyboardType: type,
      onTap: onclicked,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        hintText: hintText,
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButton(context,{
  Color color = primaryColor,
  bool isUppercase = false,
  required Function() onpressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
          onPressed: onpressed,
          child: Text(
            '${isUppercase ? text.toUpperCase() : text}',
            style:  Theme.of(context).textTheme.bodyMedium,
          )),
    );

Widget defaultTextButton(context,
        {required String? text, required Function()? onAction}) =>
    TextButton(
      onPressed: onAction,
      child: Text(text!.toUpperCase(),style: const TextStyle(fontSize: 15.0)),
    );

void showToast(String message, ToastStates state) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: resolveToastStates(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color resolveToastStates(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildSeperator([double padding = 5.0,Color color =Colors.grey]) => Padding(
    padding: EdgeInsets.symmetric(vertical: padding),
    child: Container(
      color: color,
      height: 1.0,
      width: double.infinity,
    ));

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
 