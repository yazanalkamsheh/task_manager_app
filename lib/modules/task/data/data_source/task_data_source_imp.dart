import 'package:base_project_v2/core/services/service_locator.dart';
import 'package:base_project_v2/modules/task/data/data_source/task_data_source.dart';
import 'package:base_project_v2/modules/task/data/models/todo_model.dart';
import 'package:base_project_v2/modules/task/domin/entities/todo_entity.dart';
import 'package:base_project_v2/modules/task/domin/parameters/todo_parameters.dart';
import '../../../../core/constants/apis_urls.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/cache_storage_services.dart';
import '../../../../core/utils/app_response.dart';
import '../../domin/parameters/get_todos_parameters.dart';

class TaskDataSourceImp extends TaskDataSource {
  _addFavoriteKeyValueToResponse(AppResponse response){
    (response.data['todos'] as List).map((todo) => (todo as Map<String, dynamic>).addAll({"isFavorite": false})).toList();
  }

  _assignFavoriteValueCachedToResponse(AppResponse response, List<TodoEntity> todoFavoriteListCached){
    for (var todo in response.data['todos']) {
      bool isFavorite = todoFavoriteListCached.any((favorite) => favorite.id == todo['id']);
      todo['isFavorite'] = isFavorite;
    }
  }

  @override
  Future<List<TodoModel>> getTodos(GetTodosParameters parameters) async {
    AppResponse response = await ApiServices().get(ApisUrls.getTodos(skip: parameters.skip, limit: parameters.limit));
    _addFavoriteKeyValueToResponse(response);
    List<TodoEntity> todoFavoriteListCached = CacheStorageServices().getTodoFavorite();
    _assignFavoriteValueCachedToResponse(response,todoFavoriteListCached);

    return response.toList<TodoModel>(TodoModel.fromJson, index: 'todos');
  }

  @override
  Future<TodoModel> addTodo(TodoParameters parameters) async {
    AppResponse response = await ApiServices().post(ApisUrls.addTodo,data: parameters.toJson());
    return TodoModel.fromJson(response.data);

  }

  @override
  Future<TodoModel> deleteTodo(TodoParameters parameters) async {
    AppResponse response = await ApiServices().delete(ApisUrls.deleteTodo(parameters.id!));
    return TodoModel.fromJson(response.data);
  }

  @override
  Future<TodoModel> updateTodo(TodoParameters parameters) async {
    AppResponse response = await ApiServices().put(ApisUrls.updateTodo(parameters.id!),data: parameters.toJsonUpdate());

    return TodoModel.fromJson(response.data);
  }
}
