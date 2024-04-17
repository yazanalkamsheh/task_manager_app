
import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/parameters/login_parameters.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImp(this.authDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(LoginParameters parameters) {
    return ErrorsHandler.handleEither(() => authDataSource.login(parameters));
  }

}
