abstract class NetworkResponse<T> {
  final T? data;
  final String? error;

  const NetworkResponse({this.data, this.error});
}

class NetworkSuccess<T> extends NetworkResponse<T> {
  const NetworkSuccess(T? data) : super(data: data);
}

class NetworkError<T> extends NetworkResponse<T> {
  const NetworkError(String? error) : super(error: error);
}