import '../../../../core/utils/base_parameters.dart';

class LoginParameters extends BaseParameters {
  final String username;
  final String password;

  const LoginParameters({
    required this.username,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "expiresInMins": 30,
      };

  @override
  List<Object> get props => [username, password];
}
