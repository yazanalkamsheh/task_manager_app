import 'package:base_project_v2/core/errors/failure.dart';
import 'package:base_project_v2/modules/auth/domain/entities/user_entity.dart';
import 'package:base_project_v2/modules/auth/domain/parameters/login_parameters.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParameters parameters);
}
