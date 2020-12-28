import 'package:dio/dio.dart';

import 'package:amadis_delivery/core/utils/constants.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:rxdart/rxdart.dart';

class ProductService {
  ProductService() {
    productPresentationList =
        BehaviorSubject<List<ProductPresentation>>.seeded(null);
  }

  BehaviorSubject<List<ProductPresentation>> productPresentationList;

  final _dio = Dio();
  final _endpoint = '$BASE_URL/products/';

  Future<void> getProducts() async {
    try {
      final response = await _dio.get(_endpoint, options: dioOptions);
      final productsList = List<ProductPresentation>.from(
        response.data['data'].map(
          (x) => ProductPresentation.fromJson(x),
        ),
      );
      productPresentationList.add([...productsList]);
    } catch (e) {
      print(e);
    }
  }
}
