import 'dart:convert';

import 'package:base_project_v2/modules/task/data/models/todo_model.dart';
import 'package:base_project_v2/modules/task/domin/entities/todo_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheStorageServices {
  static CacheStorageServices? _instance;
  static SharedPreferences? _preferences;

  CacheStorageServices._();

  factory CacheStorageServices() => _instance ??= CacheStorageServices._();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String token) async =>
      await _preferences?.setString(_Keys.token, token);

  Future<void> removeToken() async => await _preferences?.remove(_Keys.token);

  bool get hasToken => _preferences?.containsKey(_Keys.token) ?? false;

  String get token => _preferences?.getString(_Keys.token) ?? 'no token';

  void addToFavorites(TodoEntity todoEntity) async {
    List<String> favoriteJsonList = _preferences?.getStringList(_Keys.favoriteTasks) ?? [];

    bool alreadyExists = favoriteJsonList.any((todoEntityJson) {
      TodoModel storedTodo = TodoModel.fromJson(json.decode(todoEntityJson));
      return storedTodo.id == todoEntity.id;
    });

    if (!alreadyExists) {
      favoriteJsonList.add(json.encode(todoEntity.toJson()));
      _preferences?.setStringList(_Keys.favoriteTasks, favoriteJsonList);
    }
  }

  List<TodoEntity> getTodoFavorite() {
    List<String> todoFavoriteJsonList = _preferences?.getStringList(_Keys.favoriteTasks) ?? [];
    List<TodoEntity> todoEntityFavorite = todoFavoriteJsonList
        .map((todoJson) => TodoEntity.fromEntity(TodoModel.fromJson(json.decode(todoJson)))).toList();
    return todoEntityFavorite;
  }

  Future<void> removeTodoFromFavorites(TodoEntity todoEntity) async {
    List<String> todoFavoriteJsonList = _preferences?.getStringList(_Keys.favoriteTasks) ?? [];

    int indexToRemove = todoFavoriteJsonList.indexWhere((todoJson) {
      TodoModel storedTodo = TodoModel.fromJson(json.decode(todoJson));
      return storedTodo.id == todoEntity.id;
    });

    if (indexToRemove != -1) {
      todoFavoriteJsonList.removeAt(indexToRemove);
      _preferences?.setStringList(_Keys.favoriteTasks, todoFavoriteJsonList);
    }
  }

  bool get hasFavoriteTasks =>
      _preferences?.containsKey(_Keys.favoriteTasks) ?? false;
}

class _Keys {
  static const String token = 'token';
  static const String favoriteTasks = 'favoriteTasks';
}
