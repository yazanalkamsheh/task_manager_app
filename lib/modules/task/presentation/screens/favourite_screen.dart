import 'package:base_project_v2/core/services/cache_storage_services.dart';
import 'package:base_project_v2/generated/locale_keys.g.dart';
import 'package:base_project_v2/modules/task/presentation/components/todo_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domin/entities/todo_entity.dart';

class FavouriteTasksScreen extends StatefulWidget {
  const FavouriteTasksScreen({super.key});

  @override
  State<FavouriteTasksScreen> createState() => _FavouriteTasksScreenState();
}

class _FavouriteTasksScreenState extends State<FavouriteTasksScreen> {
  List<TodoEntity> todoList = [];
  List<TodoEntity> todoFavoriteRemoved = [];

  @override
  void initState() {
    todoList = CacheStorageServices().getTodoFavorite();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            context.pop(todoFavoriteRemoved);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(16),
                bottomStart: Radius.circular(16))),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.green,
        centerTitle: true,
        title: Text(
          LocaleKeys.favouriteTasks.tr(context: context),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsetsDirectional.all(3.w),
        itemCount: todoList.length,
        separatorBuilder: (context, index) => SizedBox(height: 4.w),
        itemBuilder: (context, index) => TodoComponent(
          todoEntity: todoList[index],
          onPressedFavorite: () async {
            await CacheStorageServices().removeTodoFromFavorites(todoList[index]);
            todoList[index] = todoList[index].copyWith(isFavorite: false);
            todoFavoriteRemoved.add(todoList[index]);
            todoList.remove(todoList[index]);
            setState(() {});
          },
        ),
      ),
    );

  }
}
