import 'package:meta/meta.dart' show required;

import '../entities/entities.dart';

abstract class Authentication {
  Future<Account> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({@required this.email, @required this.secret});

}