import 'package:base_project_v2/core/extensions/ui_extensions/task_component_theme.dart';
import 'package:base_project_v2/core/themes/app_theme.dart';
import 'package:base_project_v2/generated/locale_keys.g.dart';
import 'package:base_project_v2/modules/task/domin/parameters/todo_parameters.dart';
import 'package:base_project_v2/modules/task/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:base_project_v2/modules/task/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../domin/entities/todo_entity.dart';
import '../routes/update_task_route.dart';

class TodoComponent extends StatelessWidget {
  TodoComponent({super.key, required this.todoEntity, required this.onPressedFavorite});
  void Function()? onPressedFavorite;
  TodoEntity todoEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          width: 100.w,
          height: 40.w,
          padding: const EdgeInsetsDirectional.all(16),
          decoration: Theme.of(context).taskDecoration(context),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "num: ${todoEntity.id}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      Text(
                        "title: ${todoEntity.todo}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      todoEntity.completed
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: !todoEntity.completed
                          ? AppColors.black
                          : AppTheme().isLight(context)
                              ? AppColors.green
                              : AppColors.white,
                    ),
                    SizedBox(
                      height: 3.w,
                    ),
                    IconButton(
                      onPressed: onPressedFavorite,
                      icon: Icon(
                        todoEntity.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: todoEntity.isFavorite ? AppColors.red : AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        PositionedDirectional(
          top: 14,
          end: 14,
          child: PopupMenuButton(
            child: const Icon(Icons.more_vert_outlined),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () =>
                      context.push(UpdateTasksRoute.name, extra: todoEntity),
                  child: Text(LocaleKeys.update.tr(context: context)),
                ),
                PopupMenuItem(
                  onTap: () => _showQuestionForDeleteDialog(context),
                  child: Text(
                    LocaleKeys.Delete.tr(context: context),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.red),
                  ),
                ),
              ];
            },
          ),
        )
      ],
    );
  }

  TodoParameters get parameters => TodoParameters(
      todoEntity.id, todoEntity.todo, todoEntity.completed, todoEntity.userId);

  void _showQuestionForDeleteDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            LocaleKeys.deleteContentDialog.tr(context: context),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  sl<TodoBloc>().add(DeleteTodoEvent(parameters));
                  context.pop();
                },
                child: Text(LocaleKeys.yes.tr(context: context))),
            TextButton(
                onPressed: () => context.pop(),
                child: Text(LocaleKeys.no.tr(context: context))),
          ],
        ),
      );
}
