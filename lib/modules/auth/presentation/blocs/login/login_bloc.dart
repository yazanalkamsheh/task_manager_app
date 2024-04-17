import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/base_state.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/parameters/login_parameters.dart';
import '../../../domain/repository/auth_repository.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, BaseState<UserEntity>> {
  final AuthRepository authRepository;
  LoginBloc(this.authRepository) : super(const BaseState<UserEntity>()) {
    on<LoginButtonTappedEvent>(_login);
  }

  FutureOr<void> _login(LoginButtonTappedEvent event, emit) async {
    emit(state.loading());
    final result = await authRepository.login(
      LoginParameters(username: event.username, password: event.password),
    );
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }
}
