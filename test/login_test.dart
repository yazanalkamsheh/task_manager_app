import 'package:base_project_v2/core/constants/apis_urls.dart';
import 'package:base_project_v2/core/services/api_services.dart';
import 'package:base_project_v2/modules/auth/data/data_source/auth_remote_data_source_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_project_v2/modules/auth/data/models/user_model.dart';
import 'package:base_project_v2/modules/auth/domain/parameters/login_parameters.dart';

class MockApiServices extends Mock implements ApiServices {}

@GenerateMocks([MockApiServices])
void main() {
  group('AuthRemoteDataSourceImp', () {
    late AuthRemoteDataSourceImp dataSource;
    late MockApiServices mockApiServices;

    setUp(() {
      mockApiServices = MockApiServices();
      dataSource = AuthRemoteDataSourceImp();
    });

    test('login - success', () async {
      const parameters = LoginParameters(username: 'kminchelle', password: '0lelplR');
      final userJson = {
        "id": 15,
        "username": "kminchelle",
        "email": "kminchelle@qq.com",
        "firstName": "Jeanne",
        "lastName": "Halvorson",
        "gender": "female",
        "image": "https://robohash.org/Jeanne.png?set=set4",
        // "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxMTIwOTAwMSwiZXhwIjoxNzExMjEyNjAxfQ.F_ZCpi2qdv97grmWiT3h7HcT1prRJasQXjUR4Nk1yo"
      };
      final expectedUser = UserModel.fromJson(userJson);

      final result = await dataSource.login(parameters);

      expect(result, equals(expectedUser));
      verify(mockApiServices.post(ApisUrls.login, data: parameters.toJson())).called(1);
    });

  });
}
