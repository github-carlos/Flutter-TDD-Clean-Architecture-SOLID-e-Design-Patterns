import 'package:meta/meta.dart' show required;

import '../entities/entities.dart';

abstract class Authentication {
  Future<Account> auth({@required String email, @required String password});
}