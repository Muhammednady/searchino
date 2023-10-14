import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchino/core/app_theme.dart';
import 'package:searchino/dependency_container.dart';
import 'package:searchino/features/auth/log_in/login_page.dart';
import 'package:searchino/features/customers/presentation/cubit/AddOrUpdateOrDelete/add_or_update_or_delete_cubit.dart';

import 'package:searchino/features/customers/presentation/cubit/customers/customers_cubit.dart';
import 'package:searchino/features/customers/presentation/pages/customers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  init();

  User? user = FirebaseAuth.instance.currentUser;
  var shpref = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: shpref,
    isLoggedIn: user != null ? true : false,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final SharedPreferences sharedPreferences;
  const MyApp(
      {super.key, required this.isLoggedIn, required this.sharedPreferences});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CustomersCubit>()..getAllCustomers(),
        ),
        BlocProvider(create: (context) => sl<AddOrUpdateOrDeleteCubit>()),
      ],
      child: MaterialApp(
        title: 'Searchino App',
        debugShowCheckedModeBanner: false,
        // themeMode: ThemeMode.light,
        theme: appTheme,
        //home: AddOrUpdatePage(isUpdate: false),
         home: !isLoggedIn ? LogInSCreen() : const CustomersPage(),
      ),
    );
  }
}
