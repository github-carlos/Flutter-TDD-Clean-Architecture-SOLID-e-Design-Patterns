import 'package:meta/meta.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_manguinho_course/domain/usecases/usecases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    await this.httpClient.request(url: url, method: 'post', body: {'email': params.email, 'password': params.secret});
  }
}

abstract class HttpClient {
  Future<void> request({@required String url, @required String method, Map body});
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  String url;
  RemoteAuthentication sut;
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test('Should call Http Client with correct values', () async {
    final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    sut.auth(params);

    verify(httpClient.request(url: url, method: 'post', body: {'email': params.email, 'password': params.secret}));
  });
}
