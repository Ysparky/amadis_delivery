import 'package:dio/dio.dart';

const emailRegex =
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

const BASE_URL = 'https://amadis-backend.herokuapp.com/api';

final dioOptions = Options(validateStatus: (status) {
  return status < 500;
});
