/// class [ApisUrls] contains all URLs to external services, services,
/// or APIs, according to the following figure
///
/// add new APIs URL in this way:
/// EX: static const String {verb}featureName = '$_baseApiUrl/{route}';

class ApisUrls {
  /// [_baseUrl] base server url
  static const String _baseUrl = 'https://dummyjson.com';

  /// [_baseImagesUrl] base Images Url
  static const String _baseImagesUrl = '$_baseUrl/uploads';
  static String baseImagesUrl(String url) => '$_baseImagesUrl/$url';

  /// Auth Feature APIs
  static const String login = '$_baseUrl/auth/login';
  static const String addTodo = '$_baseUrl/todos/add';
  static String updateTodo(int id) => '$_baseUrl/todos/$id';
  static String deleteTodo(int id) => '$_baseUrl/todos/$id';
  static String getTodos({int? skip, int? limit}) => '$_baseUrl/todos?limit=$limit&skip=$skip';

  /// Category Feature APIs
  static String getCategories(String id) =>
      '$_baseUrl/categories/section/$id?lang=en';
}
