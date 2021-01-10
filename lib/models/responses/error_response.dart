import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.status,
    this.data,
    this.message,
  });

  final String status;
  final Data data;
  final String message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json['status'],
        data: Data.fromJson(json['data']),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
        'message': message,
      };
}

class Data {
  Data({
    this.error,
  });

  final String error;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        error: json['error'],
      );

  Map<String, dynamic> toJson() => {
        'error': error,
      };
}
