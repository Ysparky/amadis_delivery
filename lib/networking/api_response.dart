class ApiResponse<T> {
  Status status;
  T data;
  String message;
  int statusCode;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message, this.statusCode) : status = Status.ERROR;

  @override
  String toString() => 'Status : $status \n Message : $message \n Data : $data';
}

enum Status { LOADING, COMPLETED, ERROR }
