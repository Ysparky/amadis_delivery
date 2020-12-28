import 'package:amadis_delivery/services/auth_service.dart';
import 'package:amadis_delivery/services/customer_service.dart';
import 'package:amadis_delivery/services/location_service.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:amadis_delivery/services/product_service.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void startServiceInjection() {
  injector.registerLazySingleton(() => AuthService());
  injector.registerLazySingleton(() => OrderService());
  injector.registerLazySingleton(() => CustomerService());
  injector.registerLazySingleton(() => LocationService());
  injector.registerLazySingleton(() => ProductService());
}
