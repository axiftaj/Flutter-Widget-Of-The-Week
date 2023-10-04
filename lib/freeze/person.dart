
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@Freezed()
class UserModel with _$UserModel {

  @JsonSerializable(fieldRename: FieldRename.snake)
   factory UserModel({
    required String firstName,
    required String lastName,
    @Default(24) int age,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

