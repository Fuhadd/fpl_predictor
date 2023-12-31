import 'package:fpl_predictor/models/user_data.dart';

abstract class LocalCache {
  ///Saves `value` to cache using `key`
  Future<void> saveToLocalCache({required String key, required dynamic value});

  ///Retrieves a cached value stored with `key`
  Object? getFromLocalCache(String key);

  ///Removes cached value stored with `key` from cache
  Future<void> removeFromLocalCache(String key);

  // //Retrieves data of current user
  // UserData getUserData();
  UserDataModel getUserData();
}
