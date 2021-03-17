import '../../domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;
  RemoteAccountModel(this.accessToken);
  factory RemoteAccountModel.fromJson(Map json) => RemoteAccountModel(json['accessToken']);

  Account toEntity() => Account(this.accessToken);
}