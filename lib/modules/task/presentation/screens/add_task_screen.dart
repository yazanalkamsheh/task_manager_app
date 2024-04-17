import 'dart:math';

import 'package:base_project_v2/core/core_component/app_button.dart';
import 'package:base_project_v2/core/core_component/loading_component.dart';
import 'package:base_project_v2/core/core_component/show_snack_bar.dart';
import 'package:base_project_v2/generated/locale_keys.g.dart';
import 'package:base_project_v2/modules/task/domin/entities/todo_entity.dart';
import 'package:base_project_v2/modules/task/domin/parameters/todo_parameters.dart';
import 'package:base_project_v2/modules/task/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:base_project_v2/modules/task/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:base_project_v2/modules/task/presentation/routes/task_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/utils/base_state.dart';
import '../../../auth/presentation/components/auth_text_form_fields.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController todoController;
  late ValueNotifier<bool> completed;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    todoController = TextEditingController();
    completed = ValueNotifier(false);
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    completed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<TodoBloc>(),
        child: BlocListener<TodoBloc, BaseState<TodoEntity>>(
          listener: _addTaskListener,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.green,
              title: Text(
                LocaleKeys.addTask.tr(context: context),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.white),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<TodoBloc, BaseState<TodoEntity>>(
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  LocaleKeys.todo.tr(context: context),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  LocaleKeys.completed.tr(context: context),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 3,
                              child: AuthTextFormField(
                                controller: todoController,
                                hint: LocaleKeys.todo.tr(context: context),
                                validator: AppVaildator.nameValidator,
                                keyboardType: TextInputType.text,
                                inputBorder: const OutlineInputBorder(),
                              ),
                            ),
                            Expanded(
                              child: ValueListenableBuilder(
                                  valueListenable: completed,
                                  builder: (context, isCompleted, child) {
                                    return Checkbox(
                                      value: isCompleted,
                                      fillColor: isCompleted
                                          ? MaterialStateProperty.all(
                                              AppColors.green)
                                          : MaterialStateProperty.all(
                                              AppColors.white),
                                      onChanged: (val) =>
                                          completed.value = val!,
                                    );
                                  }),
                            ),
                          ],
                        ),

                        // password

                        SizedBox(height: 3.w),

                        // loading
                        state.isLoading
                            ? const LoadingComponent()
                            : const SizedBox.shrink(),

                        // button
                        if (!state.isLoading)
                          AppButton(
                            lable: LocaleKeys.add.tr(context: context),
                            onTap: () => _addTaskPressed(context, state),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  TodoParameters get todoParameters => TodoParameters(Random().nextInt(101),
      todoController.text, completed.value, Random().nextInt(101));

  void _addTaskPressed(BuildContext context, BaseState<void> state) {
    if (!(formKey.currentState!.validate()) || state.isLoading) return;

    context.read<TodoBloc>().add(AddTodoEvent(todoParameters));
  }

  void _addTaskListener(BuildContext context, BaseState<TodoEntity> state) {
    if (state.isError) showSnackBar(context, state.errorMessage);

    if (state.isSuccess) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(LocaleKeys.addResult.tr(context: context), style: Theme.of(context).textTheme.bodySmall),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Todo: ${state.data?.todo}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Completed: ${state.data?.completed}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => context.go(TasksRoute.name),
              child: Text(
                LocaleKeys.yes.tr(context: context),
              ),
            ),
          ],
        ),
      );
    }
  }
}
