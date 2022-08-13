abstract class Resource<T> {
  final T? data;
  final String? message;
  Resource({this.data, this.message});
}

class ResourceSucess<T> extends Resource<T?> {
  ResourceSucess({T? data, String? message})
      : super(data: data, message: message);
}

class ResourceFailed<T> extends Resource<T> {
  ResourceFailed({String? message}) : super(data: null, message: message);
}
