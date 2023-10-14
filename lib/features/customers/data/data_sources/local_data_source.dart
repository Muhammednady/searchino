import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:searchino/core/error/exceptions.dart';
import 'package:searchino/core/strings/messages.dart';
import 'package:searchino/features/customers/data/model/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CustomersLocalDataSource {
  List<CustomerModel> getCachedCustomers();
  cacheCustomers(List<CustomerModel> customers);
}

class CustomersLocalDataSourceImpl extends CustomersLocalDataSource {
  SharedPreferences sharedPreferences;
  CustomersLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<Unit> cacheCustomers(List<CustomerModel> customers) async {
    //List customerToJson = customers.map((e) => null); if error here
    String jsonString = json.encode(customers);
    await sharedPreferences.setString(CACHED_CUSTOMERS, jsonString);
    return Future.value(unit);
  }

  @override
  List<CustomerModel> getCachedCustomers() {
    String? data = sharedPreferences.getString(CACHED_CUSTOMERS);
    if (data != null) {
      //List customerToJson = customers.map((e) => null); if error here

      var jsonDecoded = json.decode(data);
      return jsonDecoded as List<CustomerModel>;
    } else {
      throw EmptyCacheException();
    }
  }
}
