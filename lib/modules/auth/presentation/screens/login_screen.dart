import 'package:base_project_v2/core/core_component/app_button.dart';
import 'package:base_project_v2/core/core_component/loading_component.dart';
import 'package:base_project_v2/core/core_component/show_snack_bar.dart';
import 'package:base_project_v2/generated/locale_keys.g.dart';
import 'package:base_project_v2/modules/task/presentation/routes/task_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/utils/base_state.dart';
import '../../domain/entities/user_entity.dart';
import '../blocs/login/login_bloc.dart';
import '../components/auth_text_form_fields.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    usernameController.text = "kminchelle";
    passwordController.text = "0lelplR";
    super.initState();
  }


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<LoginBloc>(),
        child: BlocListener<LoginBloc, BaseState<UserEntity>>(
          listener: _loginListener,
          child: Scaffold(
            appBar: AppBar(),
            body: BlocBuilder<LoginBloc, BaseState<UserEntity>>(
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    children: [
                      // Header
                      Text(
                        LocaleKeys.welcomeBack.tr(context: context),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        LocaleKeys.enterYouDataToContinue.tr(context: context),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),

                      // User Name
                      SizedBox(height: 8.w),
                      Text(
                        LocaleKeys.userName.tr(context: context),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      AuthTextFormField(
                        controller: usernameController,
                        hint: LocaleKeys.enterYourUserName.tr(context: context),
                        validator: AppVaildator.nameValidator,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.person,
                          size: 18.sp,
                        ),
                      ),

                      // password
                      SizedBox(height: 4.w),
                      Text(
                        LocaleKeys.password.tr(context: context),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      AuthTextFormField(
                        controller: passwordController,
                        hint: LocaleKeys.enterPassword.tr(context: context),
                        validator: AppVaildator.passwordValidator,
                        keyboardType: TextInputType.text,
                        isPass: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 18.sp,
                        ),
                      ),
                      SizedBox(height: 45.w),

                      // loading
                      state.isLoading
                          ? const LoadingComponent()
                          : const SizedBox.shrink(),

                      // button
                      if(!state.isLoading)
                      AppButton(
                        lable: LocaleKeys.login.tr(context: context),
                        onTap: () => _loginPressed(context, state),
                      ),

                      // fotter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.doNotHaveAnAccount.tr(context: context),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          TextButton(
                            onPressed: (){},
                            child: Text(
                              LocaleKeys.register.tr(context: context),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          )
                        ],
                      ),


                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  void _loginPressed(BuildContext context, BaseState<UserEntity> state) {
    if (!(formKey.currentState!.validate()) || state.isLoading) return;

    context.read<LoginBloc>().add(
          LoginButtonTappedEvent(
            password: passwordController.text,
            username: usernameController.text,
          ),
        );
  }

  void _loginListener(BuildContext context, BaseState<UserEntity> state) {
    if (state.isError) showSnackBar(context, state.errorMessage);

    if (state.isSuccess) {
      context.go(TasksRoute.name);
      showSnackBar(context, LocaleKeys.loginDone.tr(context: context));
    }
  }
}
