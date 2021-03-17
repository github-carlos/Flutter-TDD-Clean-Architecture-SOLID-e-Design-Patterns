import 'package:meta/meta.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/authentication.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    try {
      await this.httpClient.request(
          url: url,
          method: 'post',
          body: RemoteAuthenticationParams.fromDomain(params).toJson());
    } on HttpError catch(error) {
      switch(error) {
        case HttpError.unauthorized:
          throw DomainError.invalidCredentials;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});

  factory RemoteAuthenticationParams.fromDomain(
          AuthenticationParams authenticationParams) =>
      RemoteAuthenticationParams(
          email: authenticationParams.email,
          password: authenticationParams.secret);
  Map toJson() => {'email': email, 'password': password};
}
