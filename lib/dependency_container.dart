import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:searchino/core/network/network_info.dart';
import 'package:searchino/features/customers/data/data_sources/local_data_source.dart';
import 'package:searchino/features/customers/data/data_sources/remote_date_source.dart';
import 'package:searchino/features/customers/data/repository/customers_repository_impl.dart';
import 'package:searchino/features/customers/domain/repository/customers_repo.dart';
import 'package:searchino/features/customers/domain/use_cases/add_a_customer_use_case.dart';
import 'package:searchino/features/customers/domain/use_cases/delete_a_customer_use_case.dart';
import 'package:searchino/features/customers/domain/use_cases/get_all_customers_use_case.dart';
import 'package:searchino/features/customers/domain/use_cases/update_a_customer_use_case.dart';
import 'package:searchino/features/customers/presentation/cubit/AddOrUpdateOrDelete/add_or_update_or_delete_cubit.dart';
import 'package:searchino/features/customers/presentation/cubit/customers/customers_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
      () => CustomersCubit(getUseCase: sl(), deleteACustomerUseCase: sl()));

  sl.registerFactory(() => AddOrUpdateOrDeleteCubit(
      addCustomerUseCase: sl(),
      updateCustomerUseCase: sl(),
      deleteACustomerUseCase: sl()));
      ////////***************////////////////////////
  sl.registerLazySingleton(() => GetAllCustomersUseCase(sl()));
  sl.registerLazySingleton(() => AddCustomerUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCustomerUseCase(sl()));
  sl.registerLazySingleton(() => DeleteACustomerUseCase(deleteACustomer: sl()));

  sl.registerLazySingleton<CustomersRepository>(() => CustomersRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<CustomersRemoteDataSource>(() =>
      CustomersRemoteDataSourceImpl(
          firebaseFirestore: sl(), firebaseStorage: sl()));
  sl.registerLazySingleton<CustomersLocalDataSource>(
      () => CustomersLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
